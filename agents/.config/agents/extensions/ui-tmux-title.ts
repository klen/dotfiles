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
let originalTitle: string | undefined;
let originalAutoRename: string | undefined;
const frames = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];

/* ─── Extension ─── */

export default function(pi: ExtensionAPI) {
  // Not in tmux, no-op extension
  if (!process.env.TMUX || !process.env.TMUX_PANE) return;

  let title: string | undefined;
  let isWorking = false;
  let loader: NodeJS.Timeout | undefined;
  let activeTool: string | undefined;

  /* ─── Title Events ─── */

  pi.on("session_start", async (_event, ctx) => {
    // Target our own pane: without it tmux resolves to the session's active
    // window, so background agents would rename the calling window.
    const info = await tmuxExec(pi, ["display-message", "-p", "-t", process.env.TMUX_PANE!, "#{window_id} #{automatic-rename} #{window_name}"]);
    if (info.code === 0) {
      const [winId, autoRename, ...name] = info.stdout.trim().split(" ");
      currentWindowId = winId;
      originalAutoRename = autoRename;
      originalTitle = name.join(" ");
    }
    title = getTitle(ctx, false)
    updateTitle(pi, title);
  });

  pi.on("model_select", async (_event, ctx) => {
    title = getTitle(ctx, isWorking, activeTool)
    updateTitle(pi, title, isWorking);
  });

  pi.on("tool_execution_start", async (event, ctx) => {
    ctx.ui.notify("Tool started: " + event.toolName);
    activeTool = event.toolName;
    title = getTitle(ctx, isWorking, activeTool)
    updateTitle(pi, title, isWorking);
  });

  pi.on("tool_execution_end", async (_event, ctx) => {
    ctx.ui.notify("Tool finished");
    activeTool = undefined;
    title = getTitle(ctx, isWorking, activeTool)
    updateTitle(pi, title, isWorking);
  });

  pi.on("agent_start", async (_event, ctx) => {
    isWorking = true;
    title = getTitle(ctx, isWorking, activeTool)
    loader = setInterval(() => {
      updateTitle(pi, title, true);
    }, 80);
  });

  pi.on("agent_end", async (_event, ctx) => {
    isWorking = false;
    activeTool = undefined;
    loader && clearInterval(loader);
    title = getTitle(ctx, isWorking)
    await updateTitle(pi, title);
    // await tmuxExec(pi, ["display-message", "-d 2000", `     === Pi finished ===`]);
    // Send bell to /dev/tty directly — pi.exec pipes stdout so output
    // never reaches the terminal otherwise.
    await pi.exec("sh", ["-c", "printf '\\a' >/dev/tty"]);
  });

  pi.on("session_shutdown", async (_event, ctx) => {
    const curDir = getProjectName(ctx.cwd);
    await setTmuxWindowTitle(pi, originalTitle || curDir);
    if (currentWindowId && originalAutoRename === "1") {
      // Only re-enable when it was automatic: rename-window turned it off, and
      // unsetting it on a manually named window would overwrite that name.
      await tmuxExec(pi, ["set-window-option", "-t", currentWindowId, "-u", "automatic-rename"]);
    }
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


/* ─── 1. Dynamic Titles ─── */

async function setTmuxWindowTitle(pi: ExtensionAPI, title: string) {
  const winId = currentWindowId;
  if (winId) {
    await tmuxExec(pi, ["rename-window", "-t", winId, title]);
  }
}

function getTitle(ctx: ExtensionContext, working: boolean, tool?: string): string | undefined {
  if (!ctx.hasUI) return; // Only set titles if UI is active
  const project = getProjectName(ctx.cwd);
  // Model and tool are noise while idle, so they only appear mid-run.
  return working ? `${project} - ${tool || ctx.model?.id || "no-model"}` : project;
}

async function updateTitle(pi: ExtensionAPI, title?: string, working?: boolean) {
  if (!title) return;
  const frame = working ? " " + frames[activeFrame++ % frames.length] : "";
  await setTmuxWindowTitle(pi, title + frame);
}
