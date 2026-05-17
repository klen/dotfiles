# AGENTS.md — nvim-naked

A minimal, modern Neovim configuration using Neovim 0.11+ built-in `vim.pack.add()` for plugin management. No lazy-loader — plugins are required eagerly on startup.

## Repository structure

```
init.lua                    -- Entry point; enables vim.loader, requires config + plugins
lua/config/
  init.lua                  -- Requires options, keymaps, auto
  options.lua               -- vim.opt, vim.g, diagnostics, UI settings
  keymaps.lua               -- Global keymaps (leader = space)
  auto.lua                  -- Autocommands (e.g., yank highlight)
lua/plugins/
  init.lua                  -- Requires all plugin files
  <name>.lua                -- One file per plugin / plugin group
  mini/
    init.lua                -- Installs mini.nvim, requires submodules
    *.lua                   -- Individual mini module configs
lua/utils.lua               -- Shared Lua utilities (fast_save, etc.)
nvim-pack-lock.json         -- Locked plugin versions (managed by nvim-pack)
```

## Editing guidelines

- **Indentation:** 2 spaces, no tabs.
- **Strings:** Prefer single quotes for regular strings; use double quotes only when escaping single quotes is awkward.
- **Plugin files:** Use `vim.pack.add({ src = 'https://github.com/...' })` to install. Place setup/config code below the install block.
- **Mini submodules:** Add new mini configs in `lua/plugins/mini/<module>.lua`, then require it from `lua/plugins/mini/init.lua`.
- **Keymaps:** Add global keymaps in `lua/config/keymaps.lua`. Use `desc` in options. Prefix plugin keymaps with `<leader>` where appropriate.
- **No `return` in plugin files** — they execute directly, unlike lazy.nvim specs.
- **LSP servers:** Register in `lua/plugins/mason.lua` (`ensure_installed`) and `lua/plugins/nvim-lspconfig.lua` (`vim.lsp.enable({...})`). Keep them in sync.

## Safe validation

- **Syntax / load check:**
  ```bash
  nvim --headless -u init.lua -c 'qa' 2>&1
  ```
  If this exits 0 and prints nothing, the config loads cleanly.
- **Lua syntax check (single file):**
  ```bash
  luac -p lua/config/options.lua
  ```
- **Format check (if stylua is installed):**
  ```bash
  stylua --check .
  ```

## High-risk commands

- **Do not run `nvim` interactively** in agent shells — it will hang waiting for a TTY.
- **Do not delete `~/.local/share/nvim/` or `~/.cache/nvim/`** — this destroys installed plugins and persistent undo history.
- **Do not edit `nvim-pack-lock.json` manually** — it is managed by the built-in package manager. If you add/remove plugins, update the Lua files and let nvim regenerate the lock.
- **Avoid `git clean -fdx`** — could remove untracked work or local plugin state if paths overlap.

## Files and directories to avoid

| Path | Why |
|------|-----|
| `nvim-pack-lock.json` | Auto-generated lockfile; manual edits will be overwritten |
| `~/.cache/nvim/undo/` | User's persistent undo history |
| `~/.local/share/nvim/site/pack/` | Installed plugin sources (managed by nvim) |

## Repo-specific notes

- **Package manager:** Uses Neovim 0.11 native `vim.pack.add()`, not lazy.nvim or packer. Plugins are downloaded on first startup and tracked in `nvim-pack-lock.json`.
- **LSP:** Mason installs servers; `vim.lsp.enable()` activates them. Both lists must be kept in sync.
- **Mini.nvim:** Many UI niceties (starter, statusline, files, pairs, surround, comment, clue, bufremove) come from this single plugin.
- **Leader key:** Space (` `). Plugin keymaps should respect this.
- **Clipboard:** `unnamedplus` is set; yank/delete interact with the system clipboard.

## Good defaults for agents

- When adding a plugin, create `lua/plugins/<plugin>.lua`, require it from `lua/plugins/init.lua`, and keep the same structure: install block at top, setup/config below.
- When adding an autocommand, place it in `lua/config/auto.lua` inside the `config` augroup.
- When adding a utility function, export it from `lua/utils.lua` and require where needed.
- Preserve existing style: concise, minimal, no unnecessary abstractions.
