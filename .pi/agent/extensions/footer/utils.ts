import type { SessionManager, Theme } from "@mariozechner/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@mariozechner/pi-tui";

export function formatHome(path: string) {
	const home = process.env.HOME || process.env.USERPROFILE;
	if (home && path.startsWith(home)) {
		return `~${path.slice(home.length)}`;
	}
	return path;
}

export function statsUsage(manager: SessionManager) {
	const total: any = {};
	const entries = manager.getEntries();
	for (const entry of entries) {
		if (entry.type === "message" && entry.message.role === "assistant") {
			const usage = entry.message.usage;
			for (const [key, value] of Object.entries(usage)) {
				if (typeof value === "number") {
					total[key] = (total[key] || 0) + value;
				}
			}
			total.cost = (total.cost || 0) + usage.cost.total;
		}
	}
	let res = "";
	if (total.input) res += `D${formatTokens(total.input)} `;
	if (total.output) res += `U${formatTokens(total.output)} `;
	if (total.cacheRead) res += `C${formatTokens(total.cacheRead)} `;
	if (total.cacheWrite) res += `W${formatTokens(total.cacheWrite)} `;
	if (total.cost) res += `$${total.cost.toFixed(3)} `;
	return res.trim();
}

export function buildLine(
	parts: string[],
	width: number,
	theme: Theme,
): string {
	if (parts.length === 0) return " ".repeat(width);
	if (parts.length === 1)
		return truncateToWidth(
			theme.fg("dim", parts[0]),
			width,
			theme.fg("dim", "..."),
		);

	const totalLength = parts.reduce((sum, part) => sum + visibleWidth(part), 0);
	const remainingSpace = width - totalLength;
	const padding = Math.max(1, Math.floor(remainingSpace / (parts.length - 1)));
	const paddingStr = " ".repeat(padding);
	const line = parts.join(paddingStr);
	return truncateToWidth(theme.fg("dim", line), width, theme.fg("dim", "..."));
}

export function sanitizeText(text: string): string {
	// Replace newlines, tabs, carriage returns with space, then collapse multiple spaces
	return text
		.replace(/[\r\n\t]/g, " ")
		.replace(/ +/g, " ")
		.trim();
}

export function formatTokens(count: number): string {
	if (count < 1000) return count.toString();
	if (count < 10000) return `${(count / 1000).toFixed(1)}k`;
	if (count < 1000000) return `${Math.round(count / 1000)}k`;
	if (count < 10000000) return `${(count / 1000000).toFixed(1)}M`;
	return `${Math.round(count / 1000000)}M`;
}
