/**
 * Funny Status Messages Extension
 *
 * Replaces the default "Working..." status with random humorous messages
 * to make waiting for the AI more entertaining.
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

const FUNNY_MESSAGES = [
	"Consulting the void...",
	"Bribing the compiler...",
	"Teaching old code new tricks...",
	"Asking the rubber duck...",
	"Summoning the code demons...",
	"Reading the tea leaves...",
	"Herding cats...",
	"Dividing by zero (safely)...",
	"Reticulating splines...",
	"Convincing electrons to behave...",
	"Mining bitcoins... kidding!",
	"Calculating the meaning of life...",
	"Optimizing the flux capacitor...",
	"Downloading more RAM...",
	"Untangling spaghetti code...",
	"Negotiating with dependencies...",
	"Reverse engineering the universe...",
	"Polishing pixels...",
	"Transcoding reality...",
	"Debugging the matrix...",
	"Overclocking brain cells...",
	"Quantum tunneling through bugs...",
	"Applying duct tape to pointers...",
	"Refactoring your expectations...",
	"Waiting for heat death of universe...",
	"Compiling excuses...",
	"Generating plausible deniability...",
	"Converting caffeine to code...",
	"Initializing genius mode...",
	"Sacrificing to the demo gods...",
	"Negotiating peace with TypeScript...",
	"Aligning tabs and spaces diplomatically...",
	"Calibrating sarcasm levels...",
	"Feeding gremlins after midnight...",
	"Profiling existential dread...",
	"Patching holes in the space-time stack...",
	"Naming variables with confidence...",
	"Whispering to flaky tests...",
	"Rendering semicolons optional...",
	"Defragmenting thought process...",
	"Assembling context from cosmic dust...",
	"Performing interpretive logging...",
	"Linting the lint...",
	"Translating requirements from human...",
	"Rebasing reality onto main...",
	"Untying knots in callback hell...",
	"Greasing the CI/CD conveyor belt...",
	"Negotiating SLA with the universe...",
	"Recharging from stack overflow energy...",
	"Stabilizing unstable abstractions...",
	"Reading the docs (allegedly)...",
	"Asking Stack Overflow nicely...",
	"Rolling for initiative...",
	"Untangling the dependency graph...",
	"Warming up the token furnace...",
	"Doing it the lazy way...",
	"Pretending to understand the regex...",
	"Counting to infinity (twice)...",
	"Negotiating with the garbage collector...",
	"Sharpening the parentheses...",
	"Folding the code origami...",
	"Sharpening Occam's razor...",
	"Adding more cowbell...",
	"Shipping it on a Friday...",
	"Blowing on the cartridge...",
	"Throwing spaghetti at the wall...",
	"Consulting the ancestors of the repo...",
	"Hydrating the dry run...",
	"Melting the cache...",
	"Zipping the bits...",
	"Bending the rules of YAML...",
	"Untangling merge conflicts...",
	"Reading commit messages from 2019...",
	"Petting the server for good luck...",
	"Turning it off and on again...",
	"Wishing really hard on a type error...",
	"Distilling logic from vibes...",
	"Measuring twice, cutting never...",
	"Asking the magic 8-ball...",
	"Bribing the linter with treats...",
	"Recalibrating the vibes...",
	"Wrangling off-by-one errors...",
	"Sharpening the JSON...",
	"Explaining the bug to a plant...",
	"Compressing the chaos...",
	"Hunting the last semicolon...",
	"Renaming things until it compiles...",
	"Loading... loading... loading...",
	"Brewing a fresh pot of logic...",
	"Escaping the yak shave...",
	"Pondering the orb...",
	"Persuading the parser...",
	"Downloading wisdom (99%)...",
	"Polishing the happy path...",
	"Reheating yesterday's code...",
	"Taming the wild pointer...",
	"Making it someone else's problem...",
	"Trusting the process (barely)...",
	"Buffering creativity...",
	"Untangling the loom of fate...",
] as const;

const FUNNY_EMOJIS = [
	"🧠",
	"🤖",
	"🚀",
	"💩",
	"🌀",
	"🦆",
	"🐛",
	"🧪",
	"🔥",
	"🎯",
	"🎲",
	"🧵",
	"🧩",
	"🪄",
	"🛰️",
	"🌌",
	"🧬",
	"🍜",
	"☕",
	"🫠",
	"😎",
	"👾",
	"🐙",
	"🦾",
	"🧱",
	"🧙",
	"🐢",
	"🦉",
	"🍕",
	"🎩",
	"🪐",
	"⭐",
	"🃏",
	"🌮",
	"🧊",
	"🕵️",
	"🐝",
	"🦄",
	"🐸",
	"🦥",
	"🦔",
	"🦑",
	"🐔",
	"🍄",
	"🥔",
] as const;

function randomItem<T>(items: readonly T[]): T {
	return items[Math.floor(Math.random() * items.length)];
}

function getRandomFunnyMessage(): string {
	return `${randomItem(FUNNY_EMOJIS)} ${randomItem(FUNNY_MESSAGES)}`;
}

export default function (pi: ExtensionAPI) {
	let currentMessage: string | undefined;

	pi.on("agent_start", async (_event, ctx) => {
		currentMessage = getRandomFunnyMessage();
		ctx.ui.setWorkingMessage(currentMessage);
	});

	pi.on("tool_execution_start", async (_event, ctx) => {
		if (!currentMessage || Math.random() <= 0.5) return;
		currentMessage = getRandomFunnyMessage();
		ctx.ui.setWorkingMessage(currentMessage);
	});

	pi.on("agent_end", async (_event, ctx) => {
		ctx.ui.setWorkingMessage();
		currentMessage = undefined;
	});

	pi.on("session_shutdown", async (_event, ctx) => {
		ctx.ui.setWorkingMessage();
		currentMessage = undefined;
	});
}
