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

import type { AliasesConfig } from "./types";
import { loadAliases } from "./utils";

export default function (pi: ExtensionAPI) {
  // Load aliases during startup so they appear in --list-models.
  // Use process.cwd() here; session_start will refresh with ctx.cwd later.
  const aliases: AliasesConfig = loadAliases(process.cwd());

  // Cache resolved models per alias so we don't re-resolve on every turn.
  // This also prevents the alias from silently switching targets if a
  // provider is added/removed mid-session.
  const resolved: Record<string, { provider: string; modelId: string }> = {};

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

  // Resolve alias to actual model and switch, returning success.
  // Caches the resolved target so re-resolution on every turn is avoided,
  // and a broken alias fails loudly (blocked) rather than silently.
  async function resolveAlias(
    aliasName: string,
    ctx: ExtensionContext,
  ): Promise<boolean> {
    // Return cached resolution if the target hasn't changed.
    const cached = resolved[aliasName];
    if (cached) {
      const currentTarget = aliases[aliasName];
      if (
        currentTarget === `${cached.provider}/${cached.modelId}` &&
        ctx.model?.provider === cached.provider &&
        ctx.model?.id === cached.modelId
      ) {
        return true; // already resolved and still valid
      }
    }

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
    resolved[aliasName] = { provider: targetProvider, modelId: targetModelId };
    return true;
  }

  // Resolve alias to real model before each agent turn.
  // We defer resolution here (not in model_select) so model cycling
  // (Ctrl+P) iterates through all aliases without position jumps.
  pi.on("before_agent_start", async (event, ctx) => {
    if (ctx.model?.provider !== "alias") return;
    const ok = await resolveAlias(ctx.model.id, ctx);
    if (!ok) {
      // Block the turn so the user knows resolution failed.
      return { block: true, reason: `Failed to resolve alias "${ctx.model.id}" — check ~/.config/agents/aliases.json or .pi/aliases.json` };
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

  // Reload aliases on each new session (picks up cwd changes and edits).
  // Also clear the resolution cache so stale targets are re-resolved.
  pi.on("session_start", async (_event, ctx) => {
    const loaded = loadAliases(ctx.cwd);
    for (const key of Object.keys(aliases)) delete aliases[key];
    Object.assign(aliases, loaded);
    registerProvider();
    for (const key of Object.keys(resolved)) delete resolved[key];
  });
}
