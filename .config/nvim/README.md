# nvim-naked

A minimal, modern Neovim configuration using **Neovim 0.11+** with the built-in
`vim.pack.add()` for plugin management — no lazy-loader, no plugin manager
wrapper.

## Quick start

```bash
nvim          # plugins install automatically on first launch
```

Locked plugin versions are tracked in `nvim-pack-lock.json`.

## Requirements

- Neovim ≥ 0.11
- Optional: `ripgrep`, `fd`, `lazygit`, `tmux` (for integration plugins)

## Features

- Native plugin management via `vim.pack.add()` — no lazy-loader
- LSP: Mason installer + `vim.lsp.enable()` + built-in completion
- Fuzzy finder: fzf.lua (files, buffers, grep, LSP symbols)
- Git: gitsigns (inline blame/diffs) + lazygit integration
- UI: mini.nvim (statusline, starter, pairs, surround, comment) + snacks.nvim (dashboard, indent, terminal)
- Tree-sitter syntax highlighting
- GitHub Copilot
- Test runner (nvim-test) + HTTP client (kulala)
- Persistent undo
- Tmux pane navigation

## Structure

- **`init.lua`** — entry point, loads `config`, `plugins`, `lsp`, and `ui`.
- **`lua/config/`** — editor settings: options, global keymaps, autocommands, colorscheme.
- **`lua/lsp/`** — LSP setup: server list, keymaps (`<leader>l`), autocommands.
- **`lua/plugins/`** — plugin install and config, one file per plugin or group.
- **`after/ftplugin/`** — filetype-specific overrides (json, python, typescript).
- **`colors/`** — colorscheme files.

## Keymaps

Leader: `<Space>`

| Key | Description |
|-----|-------------|
| `<CR>` | Save file |
| `<S-CR>` | Fast save (no autocommands) |
| `<C-c>` | Clear search highlight, diff update, redraw |
| `<leader>qq` | Quit Neovim |
| `<leader>re` | Restart Neovim |
| `<leader>rl` | Restart LSP |
| `<leader>br` | Reload buffer from disk |
| `<C-w>cc` | Close window |
| `<C-w>s` | Horizontal split |
| `<C-Space>` | Trigger completion (insert mode) |
| `<Esc>` / `<C-[>` | Exit terminal mode |

LSP keymaps are under `<leader>l` (see `lua/lsp/keymaps.lua`).

For a full list of keymaps with descriptions, use `<leader>?` (mini.clue).

## Plugins

### Code
- **treesitter** — Syntax highlighting, folding, incremental selection
- **mason** — LSP/Formatter/Linter installer
- **nvim-lspconfig** — LSP client configuration
- **Copilot** — GitHub Copilot completion
- **gitsigns + lazygit** — Git integration
- **nvim-test** — Test runner
- **kulala** — HTTP client (`.http` files)

### UI
- **fzf.lua** — Fuzzy finder (files, buffers, grep, etc.)
- **mini.nvim** — Statusline, starter screen, file explorer, pairs, surround, comment, key hints
- **snacks.nvim** — Dashboard, indent guides, terminal, toggles, bigfile handling
- **tmux** — Seamless tmux pane navigation
- **bqf** — Better quickfix list

### Colorscheme
- **covid19** — Custom colorscheme (built with lush.nvim)

## Makefile

```bash
make clear    # Wipe all Neovim state (plugins, cache, undo)
```

> ⚠️ Destructive — removes `~/.local/share/nvim`, `~/.local/state/nvim`, and `~/.cache/nvim`.

## Validation

```bash
# Check config loads cleanly
nvim --headless -u init.lua -c 'qa' 2>&1

# Lua syntax check
luac -p lua/config/options.lua
```
