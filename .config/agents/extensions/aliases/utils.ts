import { join } from "node:path";
import { existsSync, readFileSync } from "node:fs";
import { getAgentDir } from "@mariozechner/pi-coding-agent";
import type { AliasesConfig } from "./types";

export function loadAliases(cwd: string): AliasesConfig {
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

