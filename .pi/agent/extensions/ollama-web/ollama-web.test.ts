/**
 * Tests for Ollama Web Tools extension
 */

import { describe, it, mock } from "node:test";
import assert from "node:assert";

const originalFetch = global.fetch;
const originalApiKey = process.env.OLLAMA_API_KEY;

function mockResponse<T>(data: T, status = 200): Response {
	return {
		ok: status >= 200 && status < 300,
		status,
		statusText: status === 200 ? "OK" : "Error",
		headers: { get: () => null } as any,
		json: () => Promise.resolve(data),
	} as Response;
}

function mockErrorResponse(status: number, statusText: string): Response {
	return {
		ok: false,
		status,
		statusText,
		headers: { get: () => null } as any,
		json: () => Promise.resolve({}),
	} as Response;
}

async function loadExtension() {
	const { default: factory } = await import("./index.ts");
	const tools: any[] = [];
	const fakePi = {
		registerTool(def: any) {
			tools.push(def);
		},
	};
	factory(fakePi as any);
	return tools;
}

describe("extension registration", () => {
	it("registers websearch and webfetch tools", async () => {
		const tools = await loadExtension();
		assert.strictEqual(tools.length, 2);
		assert.strictEqual(tools[0].name, "websearch");
		assert.strictEqual(tools[1].name, "webfetch");
	});
});

describe("websearch tool", () => {
	it("calls Ollama web_search API with query", async () => {
		delete process.env.OLLAMA_API_KEY;
		const mockData = {
			results: [
				{ title: "What is Ollama?", url: "https://ollama.com/blog/what-is-ollama", content: "Ollama is a tool..." },
			],
		};
		const mockFetch = mock.fn(() => Promise.resolve(mockResponse(mockData)));
		global.fetch = mockFetch as unknown as typeof fetch;

		const tools = await loadExtension();
		const tool = tools.find((t) => t.name === "websearch");
		const result = await tool.execute("tc1", { query: "what is ollama?" }, undefined, undefined, {} as any);

		assert.strictEqual(mockFetch.mock.calls.length, 1);
		const [url, options] = mockFetch.mock.calls[0].arguments;
		assert.strictEqual(url, "https://ollama.com/api/web_search");
		assert.strictEqual((options as RequestInit).method, "POST");
		const body = JSON.parse((options as RequestInit).body as string);
		assert.strictEqual(body.query, "what is ollama?");
		assert.strictEqual(body.maxResults, undefined);
		assert.ok(result.content[0].text.includes("What is Ollama?"));

		global.fetch = originalFetch;
	});

	it("passes maxResults clamped by Ollama API", async () => {
		const mockData = { results: [] };
		const mockFetch = mock.fn(() => Promise.resolve(mockResponse(mockData)));
		global.fetch = mockFetch as unknown as typeof fetch;

		const tools = await loadExtension();
		const tool = tools.find((t) => t.name === "websearch");
		await tool.execute("tc1", { query: "test", max_results: 3 }, undefined, undefined, {} as any);

		const [, options] = mockFetch.mock.calls[0].arguments;
		const body = JSON.parse((options as RequestInit).body as string);
		assert.strictEqual(body.max_results, 3);

		global.fetch = originalFetch;
	});

	it("throws on API error", async () => {
		const mockFetch = mock.fn(() => Promise.resolve(mockErrorResponse(500, "Internal Server Error")));
		global.fetch = mockFetch as unknown as typeof fetch;

		const tools = await loadExtension();
		const tool = tools.find((t) => t.name === "websearch");
		await assert.rejects(
			async () => await tool.execute("tc1", { query: "test" }, undefined, undefined, {} as any),
			/web_search failed: 500 Internal Server Error/,
		);

		global.fetch = originalFetch;
	});

	it("passes abort signal through fetch wrapper", async () => {
		const mockData = { results: [] };
		const mockFetch = mock.fn(() => Promise.resolve(mockResponse(mockData)));
		global.fetch = mockFetch as unknown as typeof fetch;

		const tools = await loadExtension();
		const tool = tools.find((t) => t.name === "websearch");
		const controller = new AbortController();
		await tool.execute("tc1", { query: "test" }, controller.signal, undefined, {} as any);

		const [, options] = mockFetch.mock.calls[0].arguments;
		assert.strictEqual((options as RequestInit).signal, controller.signal);

		global.fetch = originalFetch;
	});

	it("sends Authorization header when OLLAMA_API_KEY is set", async () => {
		process.env.OLLAMA_API_KEY = "test-key-123";
		const mockData = { results: [] };
		const mockFetch = mock.fn(() => Promise.resolve(mockResponse(mockData)));
		global.fetch = mockFetch as unknown as typeof fetch;

		const tools = await loadExtension();
		const tool = tools.find((t) => t.name === "websearch");
		await tool.execute("tc1", { query: "test" }, undefined, undefined, {} as any);

		const [, options] = mockFetch.mock.calls[0].arguments;
		const headers = (options as RequestInit).headers as Record<string, string>;
		assert.strictEqual(headers["Authorization"], "Bearer test-key-123");

		global.fetch = originalFetch;
		process.env.OLLAMA_API_KEY = originalApiKey;
	});
});

describe("webfetch tool", () => {
	it("calls Ollama web_fetch API with url", async () => {
		delete process.env.OLLAMA_API_KEY;
		const mockData = {
			title: "Example Domain",
			url: "https://example.com",
			content: "This domain is for use in illustrative examples.",
			links: ["https://www.iana.org/domains/example"],
		};
		const mockFetch = mock.fn(() => Promise.resolve(mockResponse(mockData)));
		global.fetch = mockFetch as unknown as typeof fetch;

		const tools = await loadExtension();
		const tool = tools.find((t) => t.name === "webfetch");
		const result = await tool.execute("tc1", { url: "https://example.com" }, undefined, undefined, {} as any);

		assert.strictEqual(mockFetch.mock.calls.length, 1);
		const [url, options] = mockFetch.mock.calls[0].arguments;
		assert.strictEqual(url, "https://ollama.com/api/web_fetch");
		assert.strictEqual((options as RequestInit).method, "POST");
		const body = JSON.parse((options as RequestInit).body as string);
		assert.strictEqual(body.url, "https://example.com");
		assert.ok(result.content[0].text.includes("Example Domain"));

		global.fetch = originalFetch;
	});

	it("throws on API error", async () => {
		const mockFetch = mock.fn(() => Promise.resolve(mockErrorResponse(404, "Not Found")));
		global.fetch = mockFetch as unknown as typeof fetch;

		const tools = await loadExtension();
		const tool = tools.find((t) => t.name === "webfetch");
		await assert.rejects(
			async () => await tool.execute("tc1", { url: "https://example.com" }, undefined, undefined, {} as any),
			/web_fetch failed: 404 Not Found/,
		);

		global.fetch = originalFetch;
	});

	it("passes abort signal through fetch wrapper", async () => {
		const mockData = { title: "", url: "", content: "", links: [] };
		const mockFetch = mock.fn(() => Promise.resolve(mockResponse(mockData)));
		global.fetch = mockFetch as unknown as typeof fetch;

		const tools = await loadExtension();
		const tool = tools.find((t) => t.name === "webfetch");
		const controller = new AbortController();
		await tool.execute("tc1", { url: "https://example.com" }, controller.signal, undefined, {} as any);

		const [, options] = mockFetch.mock.calls[0].arguments;
		assert.strictEqual((options as RequestInit).signal, controller.signal);

		global.fetch = originalFetch;
	});

	it("sends Authorization header when OLLAMA_API_KEY is set", async () => {
		process.env.OLLAMA_API_KEY = "secret-token";
		const mockData = { title: "", url: "", content: "", links: [] };
		const mockFetch = mock.fn(() => Promise.resolve(mockResponse(mockData)));
		global.fetch = mockFetch as unknown as typeof fetch;

		const tools = await loadExtension();
		const tool = tools.find((t) => t.name === "webfetch");
		await tool.execute("tc1", { url: "https://example.com" }, undefined, undefined, {} as any);

		const [, options] = mockFetch.mock.calls[0].arguments;
		const headers = (options as RequestInit).headers as Record<string, string>;
		assert.strictEqual(headers["Authorization"], "Bearer secret-token");

		global.fetch = originalFetch;
		process.env.OLLAMA_API_KEY = originalApiKey;
	});
});
