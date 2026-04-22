import {
	CustomEditor,
	type ExtensionAPI,
	type SessionManager,
} from "@mariozechner/pi-coding-agent";
import { Editor, truncateToWidth, visibleWidth } from "@mariozechner/pi-tui";
import {
	buildLine,
	formatHome,
	formatTokens,
	sanitizeText,
	statsUsage,
} from "./utils";

export default function (pi: ExtensionAPI) {
	// Bind to session start event to set the footer
	pi.on("session_start", (_event, ctx) => {
		ctx.ui.setEditorComponent((tui, theme, keybindings) => {
			const editor = new CustomEditor(tui, theme, keybindings);
			Object.defineProperty(editor, "borderColor", {
				get: () => (str: string) => ctx.ui.theme.fg("border", str),
				set: () => {
					// Border ownership stays with the editor, so ignore attempts to set it from outside
				},
			});
			return editor;
		});

		ctx.ui.setFooter((tui, theme, footerData) => {
			return {
				dispose: footerData.onBranchChange(() => tui.requestRender()),
				invalidate() {},
				render(width) {
					const manager = ctx.sessionManager as SessionManager;

					// Get the current working directory and format it
					let pwdLeft = theme.fg("mdLink", formatHome(manager.getCwd()));

					// Get the current Git branch
					const branch = footerData.getGitBranch();
					if (branch) pwdLeft += theme.fg("syntaxString", ` (${branch})`);

					// Get the current session name
					let pwdRight = "";
					const sessionName = manager.getSessionName();
					if (sessionName) pwdRight = sessionName;

					const pwd = buildLine([pwdLeft, pwdRight], width, theme);

					// Calculate context usage from session (handles compaction correctly).
					// After compaction, tokens are unknown until the next LLM response.
					const contextUsage = ctx.getContextUsage();
					const contextWindow =
						contextUsage?.contextWindow ?? ctx.model?.contextWindow ?? 0;
					const contextPercentValue = contextUsage?.percent ?? 0;

					let contextPercent = `${contextUsage?.percent !== null ? contextPercentValue.toFixed(1) : "?"}%/${formatTokens(contextWindow)}`;
					if (contextPercentValue > 90)
						contextPercent = theme.fg("error", contextPercent);
					else if (contextPercentValue > 75)
						contextPercent = theme.fg("warning", contextPercent);

					let stats = contextPercent;

					// Get usage stats
					const usageStats = statsUsage(manager);

					// Get the current model
					const model = ctx.model?.id || "no-model";

					// Thinking level
					const sessionContext = manager.buildSessionContext();
					const thinkingLevel = sessionContext.thinkingLevel;
					const think = theme.fg(
						(thinkingColors[thinkingLevel] as any) || "dim",
						thinkingLevel.toUpperCase(),
					);

					stats = buildLine(
						[stats, usageStats, `${model} / ${think}`],
						width,
						theme,
					);

					// Colorize
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

	pi.registerCommand("footer", {
		description: "A command to reset default footer",
		handler: async (_args, ctx) => {
			ctx.ui.setFooter(undefined);
		},
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
