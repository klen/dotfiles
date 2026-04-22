/**
 * Ollama Web Tools - websearch and webfetch using Ollama's web APIs
 *
 * Registers two tools:
 * - websearch: Performs a web search via Ollama's API
 * - webfetch: Fetches a single web page via Ollama's API
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { Type } from "@sinclair/typebox";

const OLLAMA_WEB_API_BASE = "https://ollama.com/api";

function getHeaders(): Record<string, string> {
	const headers: Record<string, string> = { "Content-Type": "application/json" };
	const apiKey = process.env.OLLAMA_API_KEY;
	if (apiKey) {
		headers["Authorization"] = `Bearer ${apiKey}`;
	}
	return headers;
}

export interface WebSearchResult {
	title: string;
	url: string;
	content: string;
}

export interface WebSearchResponse {
	results: WebSearchResult[];
}

export interface WebFetchResponse {
	title: string;
	url?: string;
	content: string;
	links: string[];
}

export async function webSearch(
	query: string,
	maxResults?: number,
	signal?: AbortSignal,
): Promise<WebSearchResponse> {
	const body: Record<string, unknown> = { query };
	if (maxResults !== undefined) {
		body.max_results = Math.min(Math.max(1, maxResults), 10);
	}

	const response = await fetch(`${OLLAMA_WEB_API_BASE}/web_search`, {
		method: "POST",
		headers: getHeaders(),
		body: JSON.stringify(body),
		signal,
	});

	if (!response.ok) {
		throw new Error(`web_search failed: ${response.status} ${response.statusText}`);
	}

	return (await response.json()) as WebSearchResponse;
}

export async function webFetch(url: string, signal?: AbortSignal): Promise<WebFetchResponse> {
	const response = await fetch(`${OLLAMA_WEB_API_BASE}/web_fetch`, {
		method: "POST",
		headers: getHeaders(),
		body: JSON.stringify({ url }),
		signal,
	});

	if (!response.ok) {
		throw new Error(`web_fetch failed: ${response.status} ${response.statusText}`);
	}

	return (await response.json()) as WebFetchResponse;
}

export default function (pi: ExtensionAPI) {
	pi.registerTool({
		name: "websearch",
		label: "Web Search",
		description:
			"Performs a web search for a single query and returns relevant results. " +
			"Each result includes the page title, URL, and a content snippet. " +
			"Use this when you need to find current information from the internet.",
		promptSnippet: "Search the web for current information",
		parameters: Type.Object({
			query: Type.String({ description: "The search query string" }),
			max_results: Type.Optional(
				Type.Number({
					description: "Maximum results to return (default 5, max 10)",
					minimum: 1,
					maximum: 10,
				}),
			),
		}),

		async execute(_toolCallId, params, signal, _onUpdate, _ctx) {
			const data = await webSearch(params.query, params.max_results, signal);

			if (data.results.length === 0) {
				return {
					content: [{ type: "text", text: "No results found." }],
					details: data,
				};
			}

			const lines: string[] = [];
			for (const result of data.results) {
				lines.push(`## ${result.title}`);
				lines.push(`URL: ${result.url}`);
				lines.push(result.content);
				lines.push("");
			}

			return {
				content: [{ type: "text", text: lines.join("\n").trim() }],
				details: data,
			};
		},
	});

	pi.registerTool({
		name: "webfetch",
		label: "Web Fetch",
		description:
			"Fetches a single web page by URL and returns its content. " +
			"Returns the page title, main content, and a list of links found on the page. " +
			"Use this when you need to read the full content of a specific page.",
		promptSnippet: "Fetch a web page by URL and read its content",
		parameters: Type.Object({
			url: Type.String({ description: "The URL to fetch" }),
		}),

		async execute(_toolCallId, params, signal, _onUpdate, _ctx) {
			const data = await webFetch(params.url, signal);

			const lines: string[] = [];
			lines.push(`Title: ${data.title}`);
			if (data.url) {
				lines.push(`URL: ${data.url}`);
			}
			lines.push("");
			lines.push(data.content);
			if (data.links.length > 0) {
				lines.push("");
				lines.push(`Links found on page (${data.links.length}):`);
				for (const link of data.links) {
					lines.push(`- ${link}`);
				}
			}

			return {
				content: [{ type: "text", text: lines.join("\n") }],
				details: data,
			};
		},
	});
}
