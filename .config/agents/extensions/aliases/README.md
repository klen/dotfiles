# Model Aliases Extension

Define models once under a consistent name and use them everywhere — presets, commands, CLI flags, other extensions, and the model picker.

## Configuration

Aliases are loaded from (in order of precedence):

1. `<cwd>/.pi/aliases.json` (project-local)
2. `~/.config/agents/aliases.json` (global)

### Example `aliases.json`

```json
{
  "tiny": "opencode-go/deepseek-v4-flash",
  "coder": "opencode-go/deepseek-v4-coder",
  "smart": "anthropic/claude-sonnet-4"
}
```

## Usage

- `/model` then pick `alias/tiny` from the list
- `pi --model alias/tiny` (CLI flag)
- Reference `alias/coder` in preset or other extension configs
- `/alias` to list configured aliases

## Testing

The test file `index.test.ts` provides comprehensive test coverage for:

- **loadAliases**: Configuration loading from JSON files
- **Alias resolution**: Resolving aliases to actual models
- **Event handlers**: `before_agent_start` and `session_start` events
- **Command handling**: The `/alias` command functionality
- **Edge cases**: Invalid targets, missing models, caching

### Running Tests

Using Make:

```bash
cd extensions/aliases
make test
```

Or manually:

```bash
# Navigate to the extension directory
cd extensions/aliases

# Compile TypeScript
npx tsc -p tsconfig.test.json

# Fix ESM imports in compiled JS
sed -i '' 's|from "./utils"|from "./utils.js"|g; s|from "./types"|from "./types.js"|g' dist/index.js

# Add package.json for ESM
echo '{"type": "module"}' > dist/package.json

# Run tests with Node.js native test runner
node --test dist/index.test.js
```

### Test Results

```text
✔ loadAliases (5.1ms)
  ✔ loads aliases from project .pi/aliases.json
  ✔ strips comment keys starting with //
  ✔ strips keys starting with _
  ✔ ignores non-string values
  ✔ handles malformed JSON gracefully
  ✔ merges global and project aliases with project taking precedence
✔ AliasesConfig type
  ✔ accepts valid alias configuration
✔ Extension behavior (mocked)
  ✔ registers provider with correct name when aliases exist
  ✔ does not register provider when no aliases configured
  ✔ resolves alias to actual model
  ✔ returns null for invalid target format (no slash)
  ✔ skips resolution for non-alias providers
  ✔ blocks resolution for unknown alias
✔ resolveAlias edge cases
  ✔ caches resolved models
  ✔ clears cache on session start
✔ /alias command
  ✔ lists configured aliases
  ✔ shows message when no aliases configured
✔ before_agent_start event
  ✔ blocks when alias cannot be resolved
  ✔ allows turn when alias resolves successfully

ℹ tests 19
ℹ pass 19
ℹ fail 0
```

## Implementation Notes

- Aliases appear in the model picker as `alias/<name>`
- Resolution happens in `before_agent_start` (right before API call)
- Cached resolutions prevent re-resolution on every turn
- Resolution cache is cleared on `session_start` to pick up config changes
- Model cycling (Ctrl+P) iterates through aliases correctly due to deferred resolution
- Comment keys (starting with `//` or `_`) are stripped from config
- Non-string values are ignored
