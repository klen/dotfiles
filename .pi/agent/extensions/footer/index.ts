import {
  type ExtensionAPI,
  type SessionManager,
} from "@mariozechner/pi-coding-agent";
import {
  buildLine,
  formatHome,
  formatTokens,
  sanitizeText,
  statsUsage,
} from "./utils";

export default function (pi: ExtensionAPI) {
  // Keep footer state in module-level variables so render closures don't capture
  // a stale ExtensionContext across session replacements or shutdown.
  let manager: SessionManager | undefined;
  let currentModelId = "no-model";
  let currentContextWindow = 0;
  let currentContextPercent: number | null = null;

  // Track tokens per second
  let messageStartTime: number | null = null;
  let currentTokensPerSecond: number | null = null;

  function refreshContext(ctx: { getContextUsage: () => { percent?: number | null; contextWindow?: number } | null | undefined; model?: { contextWindow?: number } | null }) {
    const usage = ctx.getContextUsage();
    currentContextPercent = usage?.percent ?? null;
    currentContextWindow = usage?.contextWindow ?? ctx.model?.contextWindow ?? 0;
  }

  // Bind to session start event to set the footer
  pi.on("session_start", (_event, ctx) => {
    manager = ctx.sessionManager as any;
    currentModelId = ctx.model?.id || "no-model";
    refreshContext(ctx);

    ctx.ui.setFooter((tui, theme, footerData) => {
      return {
        dispose: footerData.onBranchChange(() => tui.requestRender()),
        invalidate() { },
        render(width) {
          // Get the current working directory and format it
          let pwdLeft = theme.fg("mdLink", formatHome(manager?.getCwd() ?? ""));

          // Get the current Git branch
          const branch = footerData.getGitBranch();
          if (branch) pwdLeft += theme.fg("syntaxString", ` (${branch})`);

          // Get the current session name
          let pwdRight = "";
          const sessionName = manager?.getSessionName();
          if (sessionName) pwdRight = sessionName;

          const pwd = buildLine([pwdLeft, pwdRight], width, theme);

          // Calculate context usage from session (handles compaction correctly).
          // After compaction, tokens are unknown until the next LLM response.
          const contextPercentValue = currentContextPercent ?? 0;
          const contextWindow = currentContextWindow;

          let contextPercent = `${currentContextPercent !== null ? contextPercentValue.toFixed(1) : "?"}%/${formatTokens(contextWindow)}`;
          if (contextPercentValue > 90)
            contextPercent = theme.fg("error", contextPercent);
          else if (contextPercentValue > 75)
            contextPercent = theme.fg("warning", contextPercent);

          let stats = contextPercent;

          // Get usage stats with tokens per second
          const usageStats = statsUsage(manager!, currentTokensPerSecond);

          // Get the current model
          const model = currentModelId;

          // Thinking level
          const sessionContext = manager?.buildSessionContext();
          const thinkingLevel = sessionContext?.thinkingLevel ?? "off";
          const think = theme.fg(
            (thinkingColors[thinkingLevel] as any) || "dim",
            thinkingLevel
          );
          const statsModel = `${model}[${think}${theme.fg("dim", "]")}`;

          stats = buildLine(
            [stats, usageStats, statsModel],
            width,
            theme,
          );

          const lines = [pwd, stats];

          // Add extension statuses on a single line, sorted by key alphabetically
          const extensionStatuses = footerData.getExtensionStatuses();
          if (extensionStatuses.size > 0) {
            const sortedStatuses = Array.from(extensionStatuses.entries())
              .sort(([a], [b]) => a.localeCompare(b))
              .map(([, text]) => sanitizeText(text));

            const statusLine = buildLine(sortedStatuses, width, theme);

            // Truncate to terminal width with dim ellipsis for consistency with footer style
            lines.push(statusLine);
          }
          return lines;
        },
      };
    });
  });

  pi.on("model_select", (event, _ctx) => {
    currentModelId = event.model.id || "no-model";
    currentContextWindow = event.model.contextWindow ?? 0;
  });

  pi.on("message_start", (event, _ctx) => {
    // Only track assistant messages for tokens/sec calculation
    if (event.message?.role === "assistant") {
      messageStartTime = Date.now();
    }
  });

  pi.on("message_end", (event, ctx) => {
    refreshContext(ctx);

    // Calculate tokens per second for assistant messages
    if (messageStartTime && event.message?.role === "assistant") {
      const endTime = Date.now();
      const duration = (endTime - messageStartTime) / 1000; // Convert to seconds

      // Use streaming token count if available, otherwise fall back to usage stats
      const outputTokens = event.message.usage?.output;

      if (outputTokens && duration > 0) {
        currentTokensPerSecond = Math.round(outputTokens / duration);
      }

      messageStartTime = null;
    }
  });

}

const thinkingColors: Record<string, string> = {
  off: "dim",
  minimal: "thinkingMinimal",
  low: "thinkingLow",
  medium: "thinkingMedium",
  high: "thinkingHigh",
  xhigh: "thinkingXhigh",
};
