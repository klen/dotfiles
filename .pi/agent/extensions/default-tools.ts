import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

const desiredTools = ["read", "bash", "edit", "write", "grep", "find"];

export default function (pi: ExtensionAPI) {
	pi.on("session_start", async (_event, ctx) => {
		const activeTools = pi.getActiveTools();
		const missed = desiredTools.filter((tool) => !activeTools.includes(tool));

		if (missed.length > 0) {
			pi.setActiveTools(activeTools.concat(missed));
			ctx.ui.notify(`Tools enabled: ${missed.join(", ")}`);
		}
	});
}
