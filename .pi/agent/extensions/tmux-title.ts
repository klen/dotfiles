/**
 * tmux Integration Extension
 *
 * Features:
 * 1. Dynamic pane/window titles — project, model, active tool
 * 2. Popup notifications — auto-popup on completion, manual popup command/tool
 */

import { type ExtensionAPI, type ExtensionContext } from "@mariozechner/pi-coding-agent";

let activeFrame = 0
let currentWindowId: string | undefined;
const frames = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];

/* ─── Extension ─── */

export default function (pi: ExtensionAPI) {
  // Not in tmux, no-op extension
  if (!process.env.TMUX) return;

  let title: string | undefined;
  let isWorking = false;
  let loader: NodeJS.Timeout | undefined;
  let activeTool: string | undefined;

  /* ─── Title Events ─── */

  pi.on("session_start", async (_event, ctx) => {
    currentWindowId = await getCurrentWindowId(pi, ctx.cwd);
    title = getTitle(ctx)
    updateTitle(pi, title);
  });

  pi.on("model_select", async (_event, ctx) => {
    title = getTitle(ctx, activeTool)
    updateTitle(pi, title, isWorking);
  });

  pi.on("tool_execution_start", async (event, ctx) => {
    ctx.ui.notify("Tool started: " + event.toolName);
    activeTool = event.toolName;
    title = getTitle(ctx, activeTool)
    updateTitle(pi, title, isWorking);
  });

  pi.on("tool_execution_end", async (_event, ctx) => {
    ctx.ui.notify("Tool finished");
    activeTool = undefined;
    title = getTitle(ctx, activeTool)
    updateTitle(pi, title, isWorking);
  });

  pi.on("agent_start", async (_event, ctx) => {
    isWorking = true;
    title = getTitle(ctx, activeTool)
    loader = setInterval(() => {
      updateTitle(pi, title, true);
    }, 80);
  });

  pi.on("agent_end", async (_event, ctx) => {
    isWorking = false;
    activeTool = undefined;
    loader && clearInterval(loader);
    title = getTitle(ctx, activeTool)
    updateTitle(pi, title);
    await tmuxExec(pi, ["display-message", "-d 2000", `     === Pi finished ===`]);
  });

  pi.on("session_shutdown", async (_event, ctx) => {
    await setTmuxWindowTitle(pi, "PI");
  });

}
/* ─── Helpers ─── */

function getProjectName(cwd: string): string {
  const parts = cwd.split("/").filter(Boolean);
  return parts[parts.length - 1] ?? cwd;
}

async function tmuxExec(pi: ExtensionAPI, args: string[]): Promise<{ stdout: string; stderr: string; code: number }> {
  try {
    return await pi.exec("tmux", args);
  } catch (e: any) {
    return { stdout: "", stderr: e?.message ?? String(e), code: 1 };
  }
}


async function getCurrentWindowId(pi: ExtensionAPI, cwd: string): Promise<string | undefined> {
  const result = await tmuxExec(pi, ["display-message", "-p", "#{window_id}"]);
  if (result.code === 0) {
    return result.stdout.trim();
  }
  return undefined;
}

/* ─── 1. Dynamic Titles ─── */

function setTmuxWindowTitle(pi: ExtensionAPI, title: string) {
  const winId = currentWindowId;
  if (winId) {
    tmuxExec(pi, ["rename-window", "-t", winId, title]);
  }
}

function getTitle(ctx: ExtensionContext, tool?: string): string | undefined {
  if (!ctx.hasUI) return; // Only set titles if UI is active
  const parts = [getProjectName(ctx.cwd)]
  parts.push(tool || ctx.model?.id || "no-model");
  return parts.join(" - ");
}

function updateTitle(pi: ExtensionAPI, title?: string, working?: boolean) {
  if (!title) return;
  const frame = working ? " " + frames[activeFrame++ % frames.length] : "";
  setTmuxWindowTitle(pi, title + frame);
}
