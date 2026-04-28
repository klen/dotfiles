/**
 * Model Aliases Extension
 *
 * Define shorthand aliases for models so you can reference them with a
 * consistent name across presets, commands, and other extensions.
 *
 * Aliases appear in the model picker as `alias/<name>` and resolve to
 * the configured target model on selection.
 *
 * Config files (merged, project takes precedence):
 *   ~/.config/agents/aliases.json  (global, resolves PI_CODING_AGENT_DIR)
 *   <cwd>/.pi/aliases.json         (project-local)
 *
 * Example aliases.json:
 * ```json
 * {
 *   "tiny": "opencode-go/deepseek-v4-flash",
 *   "coder": "opencode-go/deepseek-v4-coder"
 * }
 * ```
 *
 * Usage:
 *   - `/model`, then pick `alias/tiny` from the list
 *   - `pi --model alias/tiny` (CLI flag)
 *   - Reference `alias/coder` in preset or other extension configs
 *   - `/alias` to list configured aliases
 *
 * The extension resolves aliases in before_agent_start (right before the
 * API call), so model cycling and picker show alias names correctly.
 */

import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";
import { getAgentDir } from "@mariozechner/pi-coding-agent";

interface AliasesConfig {
  [name: string]: string; // alias → "provider/model"
}

function loadAliases(cwd: string): AliasesConfig {
  const globalPath = join(getAgentDir(), "aliases.json");
  const projectPath = join(cwd, ".pi", "aliases.json");

  function loadFile(path: string): AliasesConfig {
    if (!existsSync(path)) return {};
    try {
      const raw = JSON.parse(readFileSync(path, "utf-8"));
      // Strip keys starting with "//" or "_" (comment conventions)
      const result: AliasesConfig = {};
      for (const [key, value] of Object.entries(raw)) {
        if (key.startsWith("//") || key.startsWith("_")) continue;
        if (typeof value !== "string") continue;
        result[key] = value;
      }
      return result;
    } catch (err) {
      console.error(`Failed to load aliases from ${path}: ${err}`);
      return {};
    }
  }

  return { ...loadFile(globalPath), ...loadFile(projectPath) };
}

export default function (pi: ExtensionAPI) {
  // Load aliases during startup so they appear in --list-models.
  // Use process.cwd() here; session_start will refresh with ctx.cwd later.
  const aliases: AliasesConfig = loadAliases(process.cwd());

  // Register the aliases provider immediately (factory phase).
  // This ensures models are available before session_start and to --list-models.
  function registerProvider() {
    const aliasNames = Object.keys(aliases);
    if (aliasNames.length === 0) return;
    pi.registerProvider("alias", {
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
  registerProvider();

  // Resolve alias to actual model and switch, returning success
  async function resolveAlias(
    aliasName: string,
    ctx: ExtensionContext,
  ): Promise<boolean> {
    const target = aliases[aliasName];
    if (!target) return false;

    const slashIndex = target.indexOf("/");
    if (slashIndex === -1) {
      ctx.ui.notify(
        `Alias "${aliasName}": invalid target "${target}" (expected provider/model)`,
        "error",
      );
      return false;
    }

    const targetProvider = target.slice(0, slashIndex);
    const targetModelId = target.slice(slashIndex + 1);

    const actualModel = ctx.modelRegistry.find(targetProvider, targetModelId);
    if (!actualModel) {
      ctx.ui.notify(
        `Alias "${aliasName}": target "${target}" not found`,
        "error",
      );
      return false;
    }

    await pi.setModel(actualModel);
    return true;
  }

  // Resolve alias to real model before each agent turn.
  // We defer resolution here (not in model_select) so model cycling
  // (Ctrl+P) iterates through all aliases without position jumps.
  pi.on("before_agent_start", async (event, ctx) => {
    if (ctx.model?.provider !== "alias") return;
    const resolved = await resolveAlias(ctx.model.id, ctx);
    if (!resolved) {
      return {
        systemPrompt:
          event.systemPrompt +
          "\n\n[System note: failed to resolve model alias. The assistant may not be able to respond.]",
      };
    }
  });

  // /alias command: list configured aliases
  pi.registerCommand("alias", {
    description: "List model aliases",
    handler: async (_args, ctx) => {
      const names = Object.keys(aliases);
      if (names.length === 0) {
        ctx.ui.notify(
          "No aliases configured. Add them to ~/.config/agents/aliases.json or .pi/aliases.json",
          "info",
        );
        return;
      }

      const lines = names.map(
        (name) => `  alias/${name}  →  ${aliases[name]}`,
      );
      const current = ctx.model
        ? `${ctx.model.provider}/${ctx.model.id}`
        : "none";
      const status = `Current model: ${current}\nConfigured aliases:\n${lines.join("\n")}`;
      ctx.ui.notify(status, "info");
    },
  });

  // Reload aliases on each new session (picks up cwd changes and edits)
  pi.on("session_start", async (_event, ctx) => {
    const loaded = loadAliases(ctx.cwd);
    for (const key of Object.keys(aliases)) delete aliases[key];
    Object.assign(aliases, loaded);
    registerProvider();
  });
}
