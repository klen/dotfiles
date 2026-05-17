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

## Structure

```
init.lua                    -- Entry point
lua/
  config/                   -- Core settings (no plugins)
    init.lua                -- Requires options + keymaps + auto
    options.lua             -- vim.opt, diagnostics, UI
    keymaps.lua             -- Global keymaps (leader = <Space>)
    auto.lua                -- Autocommands
    ui.lua                  -- Colorscheme & appearance
  lsp/                      -- LSP setup (separate from plugins)
    init.lua                -- Entry point
    config.lua              -- Server lists (ensure_installed + enabled)
    keymaps.lua             -- LSP keymaps under <leader>l
    auto.lua                -- LSP autocommands
  plugins/                  -- Plugin install + config
    init.lua                -- Requires all plugin files
    mini/                   -- mini.nvim submodules (statusline, starter, pairs, …)
    snacks/                 -- snacks.nvim submodules (dashboard, indent, terminal, …)
    builtin/                -- Built-in plugin enhancements (undotree, difftool)
    treesitter.lua          -- Tree-sitter
    mason.lua               -- LSP/formatter/linter installer
    lspconfig.lua           -- vim.lsp.enable()
    fzf.lua                 -- Fuzzy finder
    git.lua                 -- Git integration (gitsigns + lazygit)
    copilot.lua             -- GitHub Copilot
    nvim-test.lua           -- Test runner
    kulala.lua              -- HTTP client
    tmux.lua                -- Tmux navigation
    lush.lua                -- Colorscheme authoring (covid19)
    bqf.lua                 -- Better quickfix
  utils.lua                 -- Shared utilities
after/ftplugin/             -- Filetype-specific overrides
colors/                     -- Colorscheme files
```

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
