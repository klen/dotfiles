# AGENTS.md

This repository contains personal dotfiles plus a Neovim configuration.
Use the guidance below when making changes.

## Quick Orientation

- Primary repo root: `/Users/horneds/dotfiles`
- Neovim config: `.config/nvim/`
- Setup playbooks: `setup/`
- Package config: `package.json`

## Build / Lint / Test Commands

There is no single build/test pipeline. Use the commands below depending on
what you changed.

### Repo Maintenance

- Install/update dotfiles: `make`
- Update repo and submodules: `make update`
- Run ansible provisioning: `make ansible`
- Install desktop casks: `make desktop`
- Stow into home directory: `make stow`
- Unstow (remove symlinks): `make unstow`

### Neovim Cache Cleanup

- Clear Neovim cache and data: `make -C .config/nvim clean`

### JavaScript / TypeScript Linting

ESLint and Prettier are configured, but there are no npm scripts.
Run them directly in the repo root if needed:

- ESLint (example): `npx eslint <path>`
- Prettier check/format (example): `npx prettier --check <path>`

### Lua Formatting

Stylua config exists for Neovim Lua files:

- Format Lua (example): `stylua .config/nvim/lua`

### Test Commands

There is no standard test runner configured at the repo level.
If you are working in the Neovim config, tests are typically run via the
Neovim test plugin with editor commands (not CLI):

- Nearest test: `:TestNearest`
- File tests: `:TestFile`
- Full suite: `:TestSuite`

When asked for a single-test CLI command, state that none is defined and
suggest the editor-based `:TestNearest` flow.

## Code Style and Conventions

### General

- Follow `.editorconfig` for indentation and newlines.
- Use LF line endings, trim trailing whitespace, and keep a final newline.
- Keep changes minimal and in the existing style of each file.

### Formatting Defaults

- Indent: 2 spaces for most files.
- Indent: 4 spaces for `*.py` and `*.rs`.
- Tabs in Makefiles.

### Lua (Neovim Config)

- Style: 2-space indent, 120 column width (see `stylua.toml`).
- Prefer local requires at top of file.
- Use `return { ... }` module tables for plugin specs.
- Keep keymaps grouped by feature, with concise `desc` strings.
- Avoid unnecessary comments; use them only for non-obvious logic.

### JavaScript / TypeScript

- ESLint config: `.eslintrc.json`.
- Prettier config: `.prettierrc.json` (no semicolons, trailing commas).
- Prefer named exports where already used; stay consistent with file style.
- Keep React JSX filename extensions to `.js` or `.jsx` where configured.

### Imports

- Keep import ordering consistent with existing files.
- Group standard library, external, and local imports when a file already
  follows that pattern.
- Avoid unused imports; remove as needed.

### Naming

- Lua: use `snake_case` for locals and functions, `PascalCase` for modules
  only when already used.
- JS/TS: use `camelCase` for variables/functions, `PascalCase` for React
  components.
- Keep keymap identifiers consistent (`<leader>...` patterns already used).

### Types

- Lua: prefer runtime checks and simple tables; avoid heavy metatable tricks.
- JS/TS: if adding TS files, favor explicit types on exported functions.

### Error Handling

- Prefer early returns for invalid/empty inputs (example: LSP list handlers).
- Use `vim.notify` for user-facing Neovim messages.
- Avoid silent failures; provide a small hint in the message when useful.

### Neovim Plugin Conventions

- Plugin specs are defined under `.config/nvim/lua/plugins/**`.
- Keep options under `opts = { ... }` when the plugin supports it.
- Use `keys = { ... }` for keymaps; keep descriptions short and clear.

### YAML / Ansible

- Preserve existing spacing and playbook structure.
- Keep tasks small and idempotent where possible.

## Repository-Specific Notes

- This repo is a personal dotfiles collection; avoid adding heavy dependencies
  or unrelated tooling without a clear reason.
- Prefer small, focused changes that do not alter user workflows unexpectedly.

## Cursor / Copilot Rules

No Cursor rules found in `.cursor/rules/` or `.cursorrules`.
No Copilot instructions found in `.github/copilot-instructions.md`.

## When in Doubt

- Read existing files in the same directory and match their patterns.
- Ask a single, targeted question only if blocked by ambiguity.
