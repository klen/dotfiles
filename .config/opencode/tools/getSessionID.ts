import { tool } from "@opencode-ai/plugin";

export default tool({
	description: "Get current session ID",
	args: {},
	async execute(arqs, context) {
		return context.sessionID;
	},
});
