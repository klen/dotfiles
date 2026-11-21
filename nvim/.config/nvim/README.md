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

- Neovim ≥ 0.11 (0.12 for the `vim._core.ui2` command-line layout)
- Optional: `git`, `rg` (grep picker), `tmux`, `bun`/`uv` (filetype lint commands)

## Features

- Native plugin management via `vim.pack.add()` — no lazy-loader
- LSP: Mason installer + `vim.lsp.enable()`, built-in completion and `gr*` keymaps (Nvim 0.11 defaults)
- Picker: snacks.picker (files, buffers, grep, LSP symbols, git log, quickfix)
- Git: vim-fugitive
- UI: mini.nvim (clue, files, pairs, statusline, surround) + snacks.nvim (dashboard, terminal, toggles, notifier, bigfile)
- Tree-sitter highlighting, folding and indent
- Commenting via the built-in `gcc`/`gc` (no plugin)
- GitHub Copilot, pi.nvim (AI agent), nvim-test, kulala (HTTP client)
- Built-in `nvim.undotree` and `nvim.difftool` core packs
- Persistent undo, tmux pane navigation, nvim-bqf for the quickfix list

## Structure

- **`init.lua`** — entry point, loads `config`, `plugins`, `lsp`, and `ui`.
- **`lua/config/`** — editor settings: options, global keymaps, autocommands, colorscheme.
- **`lua/lsp/`** — LSP setup: server list, per-client keymaps, autocommands.
- **`lua/plugins/`** — one file per plugin, named after its repository without the
  `.nvim`/`.lua` suffix: `nvim-treesitter.lua`, `kulala.lua`, `mini/init.lua`.
  `<leader>pl` + `<CR>` relies on this, so keep the names in sync.
- **`lua/plugins/builtin/`** — `vim.pack` helpers and Neovim core packs, not plugins.
- **`after/ftplugin/`** — filetype overrides (json, python, typescript).
- **`colors/`** — colorscheme files.

## Keymaps

Leader: `<Space>`

| Key | Description |
|-----|-------------|
| `<CR>` | Save file |
| `<S-CR>` | Fast save (no autocommands) |
| `<C-c>` | Clear search highlight, diff update, redraw |
| `<leader>qq` | Quit Neovim |
| `<leader>dr` | Restart Neovim |
| `<leader>br` / `<leader>bd` | Reload buffer from disk / delete buffer |
| `<leader><Space>` / `<leader>/` | Find files / grep |
| `<leader>f*` | Find: buffers, help, keymaps, highlights, notifications, recent files, LSP symbols, word under cursor |
| `<leader>g*` | Git: status, diff, blame, browse, commits |
| `<leader>o*` | Toggles: wrap, list, numbers, spell, conceal, fold, treesitter, background, diagnostics |
| `<leader>p*` | Plugins: list (`pl`), update all (`pu`), check (`pc`) |
| `<leader>u` | Undotree |
| `<leader>d*` | Diff: this / put / get |
| `<leader>t*` | Tests |
| `<leader>h*` | HTTP requests (kulala) |
| `<leader>a*` | AI prompts (pi.nvim) |
| `<C-Space>` | Trigger completion (insert mode) |
| `<Esc>` / `<C-[>` | Exit terminal mode |

### LSP (buffer-local, Nvim 0.11 defaults plus a few extras)

| Key | Description |
|-----|-------------|
| `grn` / `gra` / `grr` | Rename / code action / references |
| `gri` / `grt` / `grx` | Implementation / type definition / codelens |
| `grd` / `grs` / `grf` / `grl` | Definition / signature help / format / fix all |
| `K` | Hover |
| `<C-n>` / `<C-p>` | Next / previous diagnostic |
| `<leader>l*` | LSP: info, restart, stop, inlay hints, workspace folders |
| `<leader>cd` / `<leader>cq` | Diagnostics float / location list |

Typing `gr` shows a mini.clue popup with all of the above.

### Plugin list (`<leader>pl`)

| Key | Description |
|-----|-------------|
| `<CR>` | Open that plugin's config file |
| `u` / `d` | Update / delete the plugin under the cursor |
| `r` / `q` | Re-check upstream / close |

## Plugins

### Code
- **nvim-treesitter** — syntax highlighting, folding, indent
- **mason** + **mason-lspconfig** — LSP server installer and bridge to `vim.lsp.enable()`
- **nvim-lspconfig** — LSP client configuration
- **copilot.lua** — GitHub Copilot completions
- **vim-fugitive** — Git integration
- **nvim-test** — test runner
- **kulala.nvim** — HTTP client (`.http` files)
- **pi.nvim** — AI agent

### UI
- **snacks.nvim** — picker, dashboard, terminal, toggles, notifier, bigfile, scroll
- **mini.nvim** — clue, files, pairs, statusline, surround
- **tmux.nvim** — seamless tmux pane navigation
- **nvim-bqf** — better quickfix list

### Colorscheme
- **covid19** — custom colorscheme (built with lush.nvim)

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
