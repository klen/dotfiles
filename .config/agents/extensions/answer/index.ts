/**
 * Q&A extraction hook - extracts questions from assistant responses
 *
 * Custom interactive TUI for answering questions.
 *
 * Demonstrates the "prompt generator" pattern with custom TUI:
 * 1. /answer command gets the last assistant message
 * 2. Shows a spinner while extracting questions as structured JSON
 * 3. Presents an interactive TUI to navigate and answer questions
 * 4. Submits the compiled answers when done
 */

import { completeSimple, type UserMessage } from "@mariozechner/pi-ai";
import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";
import { BorderedLoader } from "@mariozechner/pi-coding-agent";
import {
  type Component,
  Editor,
  type EditorTheme,
  Key,
  matchesKey,
  truncateToWidth,
  type TUI,
  visibleWidth,
  wrapTextWithAnsi,
} from "@mariozechner/pi-tui";
import type { Model, Api } from "@mariozechner/pi-ai";

// Configurable extraction model.
// Format: "provider/modelId" (e.g., "anthropic/claude-haiku-4-5") or just "modelId"
// Set to null to always use the currently connected PI model.
const EXTRACTION_MODEL: string | null = "opencode-go/deepseek-v4-flash";

// Structured output format for question extraction
interface ExtractedQuestion {
  question: string;
  context?: string;
  options?: string[];
}

interface ExtractionResult {
  questions: ExtractedQuestion[];
}

interface ExtractionUsage {
  input: number;
  output: number;
  totalTokens: number;
  cost: number;
}

interface ExtractionData {
  result: ExtractionResult | null;
  usage?: ExtractionUsage;
}

const SYSTEM_PROMPT = `You are a question extractor. Given text from a conversation, extract any questions that need answering.

Output a JSON object with this structure:
{
  "questions": [
    {
      "question": "The question text",
      "context": "Optional context that helps answer the question"
    }
  ]
}

Rules:
- Extract all questions that require user input
- Keep questions in the order they appeared
- Be concise with question text
- Include context only when it provides essential information for answering
- If no questions are found, return {"questions": []}
- IMPORTANT: When a question has multiple choice options (a, b, c or 1, 2, 3), preserve them EXACTLY in the context field using the format "(a) Option one, (b) Option two, (c) Option three"

Example output:
{
  "questions": [
    {
      "question": "What is your preferred database?",
      "context": "(a) MySQL, (b) PostgreSQL, (c) SQLite"
    },
    {
      "question": "Should we use TypeScript or JavaScript?",
      "context": "(a) TypeScript, (b) JavaScript"
    },
    {
      "question": "What port should the server run on?"
    }
  ]
}`;



/**
 * Parse the JSON response from the LLM
 */
function parseExtractionResult(text: string): ExtractionResult | null {
  try {
    // Try to find JSON in the response (it might be wrapped in markdown code blocks)
    let jsonStr = text;

    // Remove markdown code block if present
    const jsonMatch = text.match(/```(?:json)?\s*([\s\S]*?)```/);
    if (jsonMatch) {
      jsonStr = jsonMatch[1].trim();
    }

    const parsed = JSON.parse(jsonStr);
    if (parsed && Array.isArray(parsed.questions)) {
      const result = parsed as ExtractionResult;
      for (const q of result.questions) {
        if (q.context) {
          q.options = parseOptions(q.context);
        }
      }
      return result;
    }
    return null;
  } catch {
    return null;
  }
}

/**
 * Parse multiple choice options from context text.
 * Detects patterns like "(a) Option one, (b) Option two" or "(1) Option, (2) Option".
 */
function parseOptions(context: string): string[] | undefined {
  const choicePattern = /\(([a-z]|[0-9]+)\)\s+/gi;
  const matches = [...context.matchAll(choicePattern)];
  if (matches.length < 2) return undefined;

  const options: string[] = [];
  for (let i = 0; i < matches.length; i++) {
    const startIndex = matches[i].index || 0;
    const endIndex = i < matches.length - 1 ? matches[i + 1].index : context.length;
    let optionText = context.slice(startIndex, endIndex).replace(/^,?\s*/, "").replace(/,\s*$/, "").trim();
    optionText = optionText.replace(/^\([a-z0-9]+\)\s*/i, "").trim();
    if (optionText) {
      options.push(optionText);
    }
  }
  return options.length >= 2 ? options : undefined;
}

/**
 * Parse a model reference string into provider and modelId.
 * Supports "provider/modelId" or just "modelId".
 */
function parseModelRef(ref: string): { provider?: string; modelId: string } {
  const parts = ref.split("/");
  if (parts.length === 2) {
    return { provider: parts[0], modelId: parts[1] };
  }
  return { modelId: parts[0] };
}

/**
 * Resolve the extraction model.
 * Tries the configured EXTRACTION_MODEL first, falls back to the current model.
 */
async function resolveExtractionModel(
  ref: string | null,
  currentModel: Model<Api>,
  modelRegistry: {
    find: (provider: string, modelId: string) => Model<Api> | undefined;
    getAll: () => Model<Api>[];
    getApiKeyAndHeaders: (model: Model<Api>) => Promise<
      | { ok: true; apiKey?: string; headers?: Record<string, string> }
      | { ok: false; error: string }
    >;
  },
): Promise<Model<Api>> {
  if (!ref) return currentModel;

  const { provider, modelId } = parseModelRef(ref);
  let found: Model<Api> | undefined;

  if (provider) {
    found = modelRegistry.find(provider, modelId);
  } else {
    // Search all models by ID
    for (const m of modelRegistry.getAll()) {
      if (m.id === modelId) {
        found = m;
        break;
      }
    }
  }

  if (found) {
    const auth = await modelRegistry.getApiKeyAndHeaders(found);
    if (auth.ok) return found;
  }

  return currentModel;
}

/**
 * Interactive Q&A component for answering extracted questions
 */
class QnAComponent implements Component {
  private questions: ExtractedQuestion[];
  private answers: string[];
  private currentIndex: number = 0;
  private editor: Editor;
  private tui: TUI;
  private onDone: (result: string | null) => void;
  private showingConfirmation: boolean = false;

  // New: select mode state
  private selectedOptionIndex: number = 0;
  private inputMode: boolean = false;

  // Cache
  private cachedWidth?: number;
  private cachedLines?: string[];

  // Colors
  private dim = (s: string) => `\x1b[2m${s}\x1b[0m`;
  private bold = (s: string) => `\x1b[1m${s}\x1b[0m`;
  private cyan = (s: string) => `\x1b[36m${s}\x1b[0m`;
  private green = (s: string) => `\x1b[32m${s}\x1b[0m`;
  private yellow = (s: string) => `\x1b[33m${s}\x1b[0m`;
  private gray = (s: string) => `\x1b[90m${s}\x1b[0m`;

  constructor(
    questions: ExtractedQuestion[],
    tui: TUI,
    onDone: (result: string | null) => void,
  ) {
    this.questions = questions;
    this.answers = questions.map(() => "");
    this.tui = tui;
    this.onDone = onDone;

    const editorTheme: EditorTheme = {
      borderColor: this.dim,
      selectList: {
        selectedBg: (s: string) => `\x1b[44m${s}\x1b[0m`,
        matchHighlight: this.cyan,
        itemSecondary: this.gray,
      },
    };

    this.editor = new Editor(tui, editorTheme);
    this.editor.disableSubmit = true;
    this.editor.onChange = () => {
      this.invalidate();
      this.tui.requestRender();
    };

    this.resetModeForCurrentQuestion();
  }

  private currentQuestion(): ExtractedQuestion {
    return this.questions[this.currentIndex];
  }

  private hasOptions(): boolean {
    const opts = this.currentQuestion().options;
    return !!opts && opts.length >= 2;
  }

  private allOptions(): string[] {
    const q = this.currentQuestion();
    return q.options ? [...q.options, "Type something..."] : [];
  }

  private resetModeForCurrentQuestion(): void {
    const q = this.currentQuestion();
    const savedAnswer = this.answers[this.currentIndex];

    if (q.options && q.options.length >= 2) {
      const idx = q.options.findIndex((opt) => opt === savedAnswer);
      if (idx >= 0) {
        this.selectedOptionIndex = idx;
        this.inputMode = false;
      } else if (savedAnswer && savedAnswer.trim().length > 0) {
        this.selectedOptionIndex = q.options.length;
        this.inputMode = true;
        this.editor.setText(savedAnswer);
      } else {
        this.selectedOptionIndex = 0;
        this.inputMode = false;
      }
    } else {
      this.inputMode = true;
      this.editor.setText(savedAnswer || "");
    }
  }

  private allQuestionsAnswered(): boolean {
    this.saveCurrentAnswer();
    return this.answers.every((a) => (a?.trim() || "").length > 0);
  }

  private saveCurrentAnswer(): void {
    if (this.inputMode) {
      this.answers[this.currentIndex] = this.editor.getText();
    }
  }

  private navigateTo(index: number): void {
    if (index < 0 || index >= this.questions.length) return;
    this.saveCurrentAnswer();
    this.currentIndex = index;
    this.resetModeForCurrentQuestion();
    this.invalidate();
  }

  private submit(): void {
    this.saveCurrentAnswer();

    const parts: string[] = [];
    for (let i = 0; i < this.questions.length; i++) {
      const q = this.questions[i];
      const a = this.answers[i]?.trim() || "(no answer)";
      parts.push(`Q: ${q.question}`);
      parts.push(`A: ${a}`);
      parts.push("");
    }

    this.onDone(parts.join("\n").trim());
  }

  private cancel(): void {
    this.onDone(null);
  }

  invalidate(): void {
    this.cachedWidth = undefined;
    this.cachedLines = undefined;
  }

  handleInput(data: string): void {
    if (this.showingConfirmation) {
      if (matchesKey(data, Key.enter) || data.toLowerCase() === "y") {
        this.submit();
        return;
      }
      if (matchesKey(data, Key.escape) || matchesKey(data, Key.ctrl("c")) || data.toLowerCase() === "n") {
        this.showingConfirmation = false;
        this.invalidate();
        this.tui.requestRender();
        return;
      }
      return;
    }

    if (matchesKey(data, Key.escape) || matchesKey(data, Key.ctrl("c"))) {
      if (this.inputMode && this.hasOptions()) {
        this.inputMode = false;
        this.editor.setText("");
        this.invalidate();
        this.tui.requestRender();
        return;
      }
      this.cancel();
      return;
    }

    // Tab / Shift+Tab / l / h navigation (next/prev question)
    // Only when NOT in input mode — h/l should type text in the editor
    if ((matchesKey(data, Key.tab) || data === "l") && !this.inputMode) {
      if (this.currentIndex < this.questions.length - 1) {
        this.navigateTo(this.currentIndex + 1);
        this.tui.requestRender();
      }
      return;
    }
    if ((matchesKey(data, Key.shift("tab")) || data === "h") && !this.inputMode) {
      if (this.currentIndex > 0) {
        this.navigateTo(this.currentIndex - 1);
        this.tui.requestRender();
      }
      return;
    }

    // Arrow up/down / k / j for question navigation
    // Only when in select mode without options — j/k should type text in the editor
    if (!this.inputMode && !this.hasOptions()) {
      if (matchesKey(data, Key.up) || data === "k") {
        if (this.currentIndex > 0) {
          this.navigateTo(this.currentIndex - 1);
          this.tui.requestRender();
          return;
        }
      }
      if (matchesKey(data, Key.down) || data === "j") {
        if (this.currentIndex < this.questions.length - 1) {
          this.navigateTo(this.currentIndex + 1);
          this.tui.requestRender();
          return;
        }
      }
    }

    // Select mode: option navigation and selection
    if (!this.inputMode && this.hasOptions()) {
      const opts = this.allOptions();

      if (matchesKey(data, Key.up) || data === "k") {
        this.selectedOptionIndex = Math.max(0, this.selectedOptionIndex - 1);
        this.invalidate();
        this.tui.requestRender();
        return;
      }
      if (matchesKey(data, Key.down) || data === "j") {
        this.selectedOptionIndex = Math.min(opts.length - 1, this.selectedOptionIndex + 1);
        this.invalidate();
        this.tui.requestRender();
        return;
      }

      if (matchesKey(data, Key.enter)) {
        const isTypeSomething = this.selectedOptionIndex === opts.length - 1;
        if (isTypeSomething) {
          this.inputMode = true;
          this.editor.setText(this.answers[this.currentIndex] || "");
          this.invalidate();
          this.tui.requestRender();
          return;
        }
        this.answers[this.currentIndex] = opts[this.selectedOptionIndex];
        if (this.currentIndex < this.questions.length - 1) {
          this.navigateTo(this.currentIndex + 1);
        } else {
          this.showingConfirmation = true;
        }
        this.invalidate();
        this.tui.requestRender();
        return;
      }

      return;
    }

    // Input mode: handle editor + Enter
    if (matchesKey(data, Key.enter) && !matchesKey(data, Key.shift("enter"))) {
      this.saveCurrentAnswer();
      if (this.currentIndex < this.questions.length - 1) {
        this.navigateTo(this.currentIndex + 1);
      } else {
        this.showingConfirmation = true;
        this.invalidate();
        this.tui.requestRender();
      }
      return;
    }

    // Pass to editor
    this.editor.handleInput(data);
    this.invalidate();
    this.tui.requestRender();
  }

  render(width: number): string[] {
    if (this.cachedLines && this.cachedWidth === width) {
      return this.cachedLines;
    }

    const lines: string[] = [];
    const boxWidth = Math.min(width - 4, 120);
    const contentWidth = boxWidth - 4;

    const horizontalLine = (count: number) => "─".repeat(count);

    const boxLine = (content: string, leftPad: number = 2): string => {
      const paddedContent = " ".repeat(leftPad) + content;
      const contentLen = visibleWidth(paddedContent);
      const rightPad = Math.max(0, boxWidth - contentLen - 2);
      return this.dim("│") + paddedContent + " ".repeat(rightPad) + this.dim("│");
    };

    const emptyBoxLine = (): string => {
      return this.dim("│") + " ".repeat(boxWidth - 2) + this.dim("│");
    };

    const padToWidth = (line: string): string => {
      const len = visibleWidth(line);
      return line + " ".repeat(Math.max(0, width - len));
    };

    // Title
    lines.push(padToWidth(this.dim("╭" + horizontalLine(boxWidth - 2) + "╮")));
    const title = `${this.bold(this.cyan("Questions"))} ${this.dim(`(${this.currentIndex + 1}/${this.questions.length})`)}`;
    lines.push(padToWidth(boxLine(title)));
    lines.push(padToWidth(this.dim("├" + horizontalLine(boxWidth - 2) + "┤")));

    // Progress indicator
    const progressParts: string[] = [];
    for (let i = 0; i < this.questions.length; i++) {
      const answered = (this.answers[i]?.trim() || "").length > 0;
      const current = i === this.currentIndex;
      if (current) {
        progressParts.push(this.cyan("●"));
      } else if (answered) {
        progressParts.push(this.green("●"));
      } else {
        progressParts.push(this.dim("○"));
      }
    }
    lines.push(padToWidth(boxLine(progressParts.join(" "))));
    lines.push(padToWidth(emptyBoxLine()));

    // Current question
    const q = this.currentQuestion();
    const questionText = `${this.bold("Q:")} ${q.question}`;
    const wrappedQuestion = wrapTextWithAnsi(questionText, contentWidth);
    for (const line of wrappedQuestion) {
      lines.push(padToWidth(boxLine(line)));
    }

    lines.push(padToWidth(emptyBoxLine()));

    // Options or editor
    if (this.hasOptions()) {
      const opts = this.allOptions();

      for (let i = 0; i < opts.length; i++) {
        const isSelected = i === this.selectedOptionIndex;
        const isTypeSomething = i === opts.length - 1;
        const prefix = isSelected ? this.cyan("> ") : "  ";
        const label = isSelected ? this.cyan(opts[i]) : opts[i];
        const suffix = isTypeSomething && this.inputMode ? this.cyan(" ✎") : "";
        lines.push(padToWidth(boxLine(`${prefix}${i + 1}. ${label}${suffix}`)));
      }

      if (this.inputMode) {
        lines.push(padToWidth(emptyBoxLine()));
        lines.push(padToWidth(boxLine(this.gray("Your answer:"))));
        const editorWidth = contentWidth - 4;
        const editorLines = this.editor.render(editorWidth);
        for (let i = 1; i < editorLines.length - 1; i++) {
          lines.push(padToWidth(boxLine("  " + editorLines[i])));
        }
      }
    } else {
      // No options - show editor directly
      const answerPrefix = this.bold("A: ");
      const editorWidth = contentWidth - 4 - 3;
      const editorLines = this.editor.render(editorWidth);
      for (let i = 1; i < editorLines.length - 1; i++) {
        if (i === 1) {
          lines.push(padToWidth(boxLine(answerPrefix + editorLines[i])));
        } else {
          lines.push(padToWidth(boxLine("   " + editorLines[i])));
        }
      }
    }

    lines.push(padToWidth(emptyBoxLine()));

    // Footer
    if (this.showingConfirmation) {
      lines.push(padToWidth(this.dim("├" + horizontalLine(boxWidth - 2) + "┤")));
      const confirmMsg = `${this.yellow("Submit all answers?")} ${this.dim("(Enter/y to confirm, Esc/n to cancel)")}`;
      lines.push(padToWidth(boxLine(truncateToWidth(confirmMsg, contentWidth))));
    } else {
      lines.push(padToWidth(this.dim("├" + horizontalLine(boxWidth - 2) + "┤")));
      let controls: string;
      if (!this.inputMode && this.hasOptions()) {
        controls = `${this.dim("↑↓/jk")} select · ${this.dim("Enter")} confirm · ${this.dim("Tab/l")} next · ${this.dim("Shift+Tab/h")} prev · ${this.dim("Esc")} cancel`;
      } else if (this.inputMode && this.hasOptions()) {
        controls = `${this.dim("Enter")} submit · ${this.dim("Esc")} back to options · ${this.dim("Tab/l")} next · ${this.dim("Shift+Tab/h")} prev`;
      } else {
        controls = `${this.dim("Tab/l/Enter")} next · ${this.dim("Shift+Tab/h")} prev · ${this.dim("Shift+Enter")} newline · ${this.dim("Esc")} cancel`;
      }
      lines.push(padToWidth(boxLine(truncateToWidth(controls, contentWidth))));
    }
    lines.push(padToWidth(this.dim("╰" + horizontalLine(boxWidth - 2) + "╯")));

    this.cachedWidth = width;
    this.cachedLines = lines;
    return lines;
  }
}

export default function (pi: ExtensionAPI) {
  const answerHandler = async (ctx: ExtensionContext) => {
    if (!ctx.hasUI) {
      ctx.ui.notify("answer requires interactive mode", "error");
      return;
    }

    if (!ctx.model) {
      ctx.ui.notify("No model selected", "error");
      return;
    }

    // Find the last assistant message on the current branch
    const branch = ctx.sessionManager.getBranch();
    let lastAssistantText: string | undefined;

    for (let i = branch.length - 1; i >= 0; i--) {
      const entry = branch[i];
      if (entry.type === "message") {
        const msg = entry.message;
        if ("role" in msg && msg.role === "assistant") {
          // Accept "stop" and "toolUse" (for self-invoked /answer via execute_command)
          if (msg.stopReason !== "stop" && msg.stopReason !== "toolUse") {
            ctx.ui.notify(`Last assistant message incomplete (${msg.stopReason})`, "error");
            return;
          }
          const textParts = msg.content
            .filter((c): c is { type: "text"; text: string } => c.type === "text")
            .map((c) => c.text);
          if (textParts.length > 0) {
            lastAssistantText = textParts.join("\n");
            break;
          }
        }
      }
    }

    if (!lastAssistantText) {
      ctx.ui.notify("No assistant messages found", "error");
      return;
    }

    // Resolve extraction model (prefer configured, fallback to current)
    const extractionModel = await resolveExtractionModel(
      EXTRACTION_MODEL,
      ctx.model,
      ctx.modelRegistry,
    );

    // Run extraction with loader UI
    const extractionData = await ctx.ui.custom<ExtractionData | null>((tui, theme, _kb, done) => {
      const loader = new BorderedLoader(tui, theme, `Extracting questions via ${extractionModel.name}...`);
      loader.onAbort = () => done(null);

      const doExtract = async () => {
        const auth = await ctx.modelRegistry.getApiKeyAndHeaders(extractionModel);
        const apiKey = auth.ok ? auth.apiKey : undefined;
        const headers = auth.ok ? auth.headers : undefined;
        const userMessage: UserMessage = {
          role: "user",
          content: [{ type: "text", text: lastAssistantText! }],
          timestamp: Date.now(),
        };

        const response = await completeSimple(
          extractionModel,
          { systemPrompt: SYSTEM_PROMPT, messages: [userMessage] },
          { apiKey, headers, signal: loader.signal, reasoning: undefined },
        );

        if (response.stopReason === "aborted") {
          return null;
        }

        const responseText = response.content
          .filter((c): c is { type: "text"; text: string } => c.type === "text")
          .map((c) => c.text)
          .join("\n");

        const result = parseExtractionResult(responseText);
        if (!result) return null;

        const usage: ExtractionUsage = {
          input: response.usage.input,
          output: response.usage.output,
          totalTokens: response.usage.totalTokens,
          cost: response.usage.cost.total,
        };

        return { result, usage };
      };

      doExtract()
        .then(done)
        .catch(() => done(null));

      return loader;
    });

    if (extractionData === null) {
      ctx.ui.notify("Cancelled", "info");
      return;
    }

    const extractionResult = extractionData.result;

    if (extractionResult === null || extractionResult.questions.length === 0) {
      ctx.ui.notify("No questions found in the last message", "info");
      return;
    }

    // Track extraction usage in session
    if (extractionData.usage) {
      const { input, output, totalTokens, cost } = extractionData.usage;
      ctx.ui.notify(
        `Extracted ${extractionResult.questions.length} questions · ${totalTokens.toLocaleString()} tokens ($${cost.toFixed(4)})`,
        "info",
      );
      pi.appendEntry("answer_extraction_usage", {
        model: `${extractionModel.provider}/${extractionModel.id}`,
        input,
        output,
        totalTokens,
        cost,
        questionsCount: extractionResult.questions.length,
      });
    }

    // Show the Q&A component
    const answersResult = await ctx.ui.custom<string | null>((tui, _theme, _kb, done) => {
      return new QnAComponent(extractionResult.questions, tui, done);
    });

    if (answersResult === null) {
      ctx.ui.notify("Cancelled", "info");
      return;
    }

    // Send the answers directly as a message and trigger a turn
    pi.sendMessage(
      {
        customType: "answers",
        content: "I answered your questions in the following way:\n\n" + answersResult,
        display: true,
      },
      { triggerTurn: true },
    );
  };

  pi.registerCommand("answer", {
    description: "Extract questions from last assistant message into interactive Q&A",
    handler: (_args, ctx) => answerHandler(ctx),
  });

  pi.registerShortcut("ctrl+.", {
    description: "Extract and answer questions",
    handler: answerHandler,
  });

  // Listen for trigger from other extensions (e.g., execute_command tool)
  pi.events.on("trigger:answer", (ctx: ExtensionContext) => {
    answerHandler(ctx);
  });
}
