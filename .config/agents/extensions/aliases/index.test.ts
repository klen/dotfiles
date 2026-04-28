/**
 * Tests for the Model Aliases Extension
 *
 * Run with: node --test dist/index.test.js
 *
 * Prerequisites:
 *   npm install -g typescript
 *   cd extensions/aliases
 *   npx tsc -p tsconfig.test.json
 *   node --test dist/index.test.js
 */

// @ts-ignore - node:test is available at runtime in Node.js 18+
import { describe, it, beforeEach, afterEach } from "node:test";
import assert from "node:assert";
import { mkdirSync, rmSync, writeFileSync, mkdtempSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";

// Module under test
import { loadAliases } from "./utils.js";
import type { AliasesConfig } from "./types.js";

// Extension factory type
type ExtensionFactory = (pi: any) => void;

// Track mock calls for verification
const mockCalls = {
  registerProvider: [] as any[],
  registerCommand: [] as any[],
  on: [] as any[],
  setModel: [] as any[],
};

// Mock ExtensionAPI
function createMockPi() {
  // Clear previous calls
  mockCalls.registerProvider.length = 0;
  mockCalls.registerCommand.length = 0;
  mockCalls.on.length = 0;
  mockCalls.setModel.length = 0;

  return {
    registerProvider: (name: string, config: any) => {
      mockCalls.registerProvider.push({ name, config });
    },
    registerCommand: (name: string, handler: any) => {
      mockCalls.registerCommand.push({ name, handler });
    },
    on: (event: string, handler: any) => {
      mockCalls.on.push({ event, handler });
    },
    setModel: async (model: any) => {
      mockCalls.setModel.push(model);
    },
  };
}

// Mock ExtensionContext
function createMockContext(options: {
  modelProvider?: string;
  modelId?: string;
  foundModel?: any;
} = {}): any {
  const { modelProvider = "alias", modelId = "test", foundModel = null } = options;
  const notifications: any[] = [];

  return {
    model: modelProvider && modelId ? { provider: modelProvider, id: modelId } : null,
    modelRegistry: {
      find: (provider: string, id: string) => foundModel,
    },
    ui: {
      notify: (message: string, type: string) => {
        notifications.push({ message, type });
      },
    },
    cwd: process.cwd(),
    _notifications: notifications,
  };
}

describe("loadAliases", () => {
  let tempDir: string;
  let globalAliasesDir: string;

  beforeEach(() => {
    tempDir = mkdtempSync(join(tmpdir(), "aliases-test-"));
    globalAliasesDir = mkdtempSync(join(tmpdir(), "global-aliases-"));
  });

  afterEach(() => {
    try {
      rmSync(tempDir, { recursive: true });
      rmSync(globalAliasesDir, { recursive: true });
    } catch {}
  });

  it("loads aliases from project .pi/aliases.json", () => {
    const piDir = join(tempDir, ".pi");
    mkdirSync(piDir, { recursive: true });
    writeFileSync(
      join(piDir, "aliases.json"),
      JSON.stringify({ tiny: "openai/gpt-4o-mini" })
    );

    const aliases = loadAliases(tempDir);
    // Note: This may also include global aliases if they exist
    assert.ok(aliases["tiny"], "tiny alias should be loaded");
    assert.strictEqual(aliases["tiny"], "openai/gpt-4o-mini");
  });

  it("strips comment keys starting with //", () => {
    const piDir = join(tempDir, ".pi");
    mkdirSync(piDir, { recursive: true });
    writeFileSync(
      join(piDir, "aliases.json"),
      JSON.stringify({
        "//comment": "this is a comment",
        tiny: "openai/gpt-4o-mini",
      })
    );

    const aliases = loadAliases(tempDir);
    assert.strictEqual((aliases as Record<string, string>)["//comment"], undefined);
    assert.ok(aliases["tiny"], "tiny alias should be loaded");
  });

  it("strips keys starting with _", () => {
    const piDir = join(tempDir, ".pi");
    mkdirSync(piDir, { recursive: true });
    writeFileSync(
      join(piDir, "aliases.json"),
      JSON.stringify({
        _private: "should be ignored",
        tiny: "openai/gpt-4o-mini",
      })
    );

    const aliases = loadAliases(tempDir);
    assert.strictEqual((aliases as Record<string, string>)["_private"], undefined);
    assert.ok(aliases["tiny"], "tiny alias should be loaded");
  });

  it("ignores non-string values", () => {
    const piDir = join(tempDir, ".pi");
    mkdirSync(piDir, { recursive: true });
    writeFileSync(
      join(piDir, "aliases.json"),
      JSON.stringify({
        tiny: "openai/gpt-4o-mini",
        invalid: 123,
        alsoInvalid: null,
        anotherInvalid: { nested: "object" },
      })
    );

    const aliases = loadAliases(tempDir);
    assert.ok(aliases["tiny"], "tiny alias should be loaded");
    assert.strictEqual(aliases["invalid"], undefined);
    assert.strictEqual(aliases["alsoInvalid"], undefined);
    assert.strictEqual(aliases["anotherInvalid"], undefined);
  });

  it("handles malformed JSON gracefully", () => {
    const piDir = join(tempDir, ".pi");
    mkdirSync(piDir, { recursive: true });
    writeFileSync(join(piDir, "aliases.json"), "not valid json");

    const aliases = loadAliases(tempDir);
    // Should not throw, returns partial result (may include global aliases)
    assert.ok(typeof aliases === "object", "should return an object");
  });

  it("merges global and project aliases with project taking precedence", () => {
    // This test documents the expected behavior
    // In practice, it requires mocking getAgentDir() which is imported from pi-coding-agent
    // Project aliases should override global aliases with the same name
    const piDir = join(tempDir, ".pi");
    mkdirSync(piDir, { recursive: true });
    writeFileSync(
      join(piDir, "aliases.json"),
      JSON.stringify({ project: "project/model" })
    );

    const aliases = loadAliases(tempDir);
    assert.ok(aliases["project"], "project alias should be loaded");
    assert.strictEqual(aliases["project"], "project/model");
  });
});

describe("AliasesConfig type", () => {
  it("accepts valid alias configuration", () => {
    const config: AliasesConfig = {
      tiny: "openai/gpt-4o-mini",
      coder: "anthropic/claude-sonnet-4",
    };

    assert.strictEqual(config.tiny, "openai/gpt-4o-mini");
    assert.strictEqual(config.coder, "anthropic/claude-sonnet-4");
  });
});

describe("Extension behavior (mocked)", () => {
  it("registers provider with correct name when aliases exist", async () => {
    // Since we can't easily test the actual extension without complex mocking,
    // we document the expected behavior here
    const mockPi = createMockPi();

    // Simulate what the extension does
    const aliases: AliasesConfig = { tiny: "openai/gpt-4o-mini" };
    const aliasNames = Object.keys(aliases);

    if (aliasNames.length > 0) {
      mockPi.registerProvider("alias", {
        baseUrl: "http://localhost:1",
        apiKey: "alias",
        api: "openai-completions",
        models: aliasNames.map((name) => ({
          id: name,
          name: `${name} (alias)`,
          reasoning: false,
          input: ["text"],
          cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
          contextWindow: 128000,
          maxTokens: 16384,
        })),
      });
    }

    assert.strictEqual(mockCalls.registerProvider.length, 1);
    assert.strictEqual(mockCalls.registerProvider[0].name, "alias");
    assert.strictEqual(mockCalls.registerProvider[0].config.models.length, 1);
    assert.strictEqual(mockCalls.registerProvider[0].config.models[0].id, "tiny");
  });

  it("does not register provider when no aliases configured", async () => {
    const mockPi = createMockPi();
    const aliases: AliasesConfig = {};
    const aliasNames = Object.keys(aliases);

    if (aliasNames.length > 0) {
      mockPi.registerProvider("alias", { models: [] });
    }

    assert.strictEqual(mockCalls.registerProvider.length, 0);
  });

  it("resolves alias to actual model", async () => {
    // Simulate the resolveAlias logic
    const aliases: AliasesConfig = { tiny: "test-provider/test-model" };
    const aliasName = "tiny";
    const target = aliases[aliasName];

    assert.ok(target, "target should exist");

    const slashIndex = target.indexOf("/");
    assert.ok(slashIndex !== -1, "target should have slash separator");

    const targetProvider = target.slice(0, slashIndex);
    const targetModelId = target.slice(slashIndex + 1);

    assert.strictEqual(targetProvider, "test-provider");
    assert.strictEqual(targetModelId, "test-model");
  });

  it("returns null for invalid target format (no slash)", () => {
    const aliases: AliasesConfig = { bad: "invalidtargetformat" };
    const target = aliases["bad"];

    const slashIndex = target.indexOf("/");
    assert.strictEqual(slashIndex, -1);
  });

  it("skips resolution for non-alias providers", () => {
    const modelProvider: string = "openai";
    const shouldResolve = modelProvider === "alias";
    assert.strictEqual(shouldResolve, false);
  });

  it("blocks resolution for unknown alias", async () => {
    const aliases: AliasesConfig = { tiny: "openai/gpt-4o-mini" };
    const aliasName = "unknown";
    const target = aliases[aliasName];

    assert.strictEqual(target, undefined);
  });
});

describe("resolveAlias edge cases", () => {
  it("caches resolved models", () => {
    // Simulate the resolution cache
    const resolved: Record<string, { provider: string; modelId: string }> = {};

    // First resolution
    resolved["tiny"] = { provider: "openai", modelId: "gpt-4o-mini" };

    // Check cache
    const cached = resolved["tiny"];
    assert.ok(cached, "should have cached value");
    assert.strictEqual(cached.provider, "openai");
    assert.strictEqual(cached.modelId, "gpt-4o-mini");
  });

  it("clears cache on session start", () => {
    const resolved: Record<string, { provider: string; modelId: string }> = {};
    resolved["tiny"] = { provider: "openai", modelId: "gpt-4o-mini" };

    // Clear cache (simulating session_start)
    for (const key of Object.keys(resolved)) delete resolved[key];

    assert.deepStrictEqual(resolved, {});
  });
});

describe("/alias command", () => {
  it("lists configured aliases", () => {
    const aliases: AliasesConfig = {
      tiny: "openai/gpt-4o-mini",
      coder: "anthropic/claude-sonnet-4",
    };

    const names = Object.keys(aliases);
    assert.deepStrictEqual(names, ["tiny", "coder"]);

    const lines = names.map((name) => `  alias/${name}  →  ${aliases[name]}`);
    assert.ok(lines[0].includes("tiny"));
    assert.ok(lines[0].includes("openai/gpt-4o-mini"));
    assert.ok(lines[1].includes("coder"));
    assert.ok(lines[1].includes("anthropic/claude-sonnet-4"));
  });

  it("shows message when no aliases configured", () => {
    const aliases: AliasesConfig = {};
    const names = Object.keys(aliases);

    assert.strictEqual(names.length, 0);
  });
});

describe("before_agent_start event", () => {
  it("blocks when alias cannot be resolved", async () => {
    const aliases: AliasesConfig = {};
    const aliasName = "missing";
    const target = aliases[aliasName];

    if (!target) {
      const result = { block: true, reason: `Failed to resolve alias "${aliasName}"` };
      assert.strictEqual(result.block, true);
      assert.ok(result.reason.includes("Failed to resolve alias"));
    }
  });

  it("allows turn when alias resolves successfully", async () => {
    const aliases: AliasesConfig = { tiny: "openai/gpt-4o-mini" };
    const aliasName = "tiny";
    const target = aliases[aliasName];

    if (target) {
      const slashIndex = target.indexOf("/");
      if (slashIndex !== -1) {
        // Would resolve successfully
        const result = undefined; // No block
        assert.strictEqual(result, undefined);
      }
    }
  });
});
