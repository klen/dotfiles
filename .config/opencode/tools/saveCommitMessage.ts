import { tool } from "@opencode-ai/plugin";
import * as fs from "fs";
import * as path from "path";

export default tool({
	description:
		"Upsert commits message in $TMPDIR/opencode/git/commit-messages/sessionID folder",
	args: {
		commitMessage: tool.schema.string().describe("Commit message"),
	},
	async execute(args, context) {
		const sessionID = context.sessionID;
		const commitMessage = args.commitMessage;
		const filePath = path.join(
			process.env.TMPDIR || "/tmp",
			"opencode",
			"git",
			"commit-messages",
			sessionID,
		);

		fs.mkdirSync(path.dirname(filePath), { recursive: true });
		fs.writeFileSync(filePath, commitMessage);

		return "Commit message upserted successfully";
	},
});
