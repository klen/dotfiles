# Project Agent

**Workspace Path:** `/Users/horneds/dotfiles/.config/nvim`
_(Note to Pi: Your file write/edit tools run in a different directory by default._
_You MUST use absolute paths starting with the Workspace Path above for ALL file operations!)_

**Generated:** 2026-04-22

## Stack

- **Editor:** Neovim (Lua config)
- **Distro:** [LazyVim](https://www.lazyvim.org/) — plugin spec framework built on `lazy.nvim`
- **Plugin Manager:** `lazy.nvim` (auto-cloned on first boot)
- **Colorscheme DSL:** `lush.nvim` — custom "covid19" theme defined in Lua HSL
- **Formatter:** `stylua` (2 spaces, 120 column width)
- **Langs / Tooling:** Lua, Python (pyrefly LSP), TypeScript, Zig, Ansible, SQL, YAML, TOML, JSON

## Structure

```text
.
├── init.lua                    -- Bootstraps lazy.nvim, imports config.lazy
├── lua/config/
│   ├── lazy.lua                -- lazy.nvim setup, LazyVim import, performance rtp tweaks
│   ├── options.lua             -- vim.opt overrides (signcolumn=number, virtualedit=all, etc.)
│   ├── keymaps.lua             -- Custom keymaps (window mgmt, diagnostics, terminal, etc.)
│   └── autocmds.lua            -- Autocmds (terminal insert mode, spell/wrap tweaks, snippet cleanup)
├── lua/plugins/
│   ├── disabled.lua            -- Disables bufferline, lualine, flash, gitsigns, venv-selector
│   ├── colors.lua              -- LazyVim opts: sets colorscheme "covid19", custom icons
│   ├── ai/                     -- copilot.lua config
│   ├── coding/                 -- blink-cmp, mini-surround
│   ├── editor/                 -- neo-tree, which-key, tmux-nvim, snacks.nvim, vim-fugitive, mason
│   │   └── snacks-nvim/        -- dashboard, indent, notifier, picker, toggle sub-modules
│   ├── formatting/             -- conform.nvim
│   ├── lsp/                    -- nvim-lspconfig, server configs (lua_ls, common)
│   ├── rest/                   -- kulala (HTTP client)
│   ├── test/                   -- nvim-test (bun runner)
│   └── ui/                     -- noice, bqf, incline, mini-starter, mini-statusline, scrollview
├── lua/utils.lua               -- Shared helpers: fast_save, diagnostic_goto, qf_from_cmd, pprint, etc.
├── colors/covid19.lua          -- Custom lush.nvim colorscheme (dark, HSL-based)
├── after/ftplugin/
│   ├── python.lua              -- colorcolumn=100, toggle breakpoint, Ruff/Pyrefly/Mypy QF commands
│   └── typescript.lua          -- BiomeQF, TSQF quickfix commands
├── lazyvim.json                -- Enabled LazyVim extras (see below)
├── stylua.toml                 -- 2-space indent, 120 col width
└── Makefile                    -- `make clean` nukes ~/.cache/nvim & ~/.local/share/nvim
```

## Commands

| Action  | Command                                           |
| ------- | ------------------------------------------------- |
| Install | Open nvim; `lazy.nvim` bootstraps automatically   |
| Update  | `:Lazy update` or `<leader>ll` → Lazy UI → update |
| Check   | `:Lazy check` or `<leader>lc`                     |
| Clean   | `make clean` (deletes cache + local share)        |
| Format  | `stylua .` (if installed)                         |

## Conventions

- **LazyVim plugin spec style** —
  each plugin is a Lua table returned from a file under `lua/plugins/**`.
- **Modular imports** — `init.lua` files in subdirectories aggregate `require("plugins.X.spec")`
  entries.
- **Stylua formatting** — 2 spaces, 120-column limit.
  Use `-- stylua: ignore start/end` sparingly for DSL blocks (e.g., lush themes).
- **Keymaps** — use `require("lazyvim.util").safe_keymap_set` (aliased as `map`)
  and prefer `desc` fields.
- **Custom utils** — shared logic lives in `lua/utils.lua`; expose globals cautiously (e.g.,
  `_G.pprint`).
- **Quickfix helpers** — language-specific commands (`RuffQF`, `TSQF`, `BiomeQF`, `PyreflyQF`,
  `MypyQF`) use `utils.qf_from_cmd`.
- **No bufferline / lualine** — intentionally disabled in favor of `mini-statusline`.

## Key Files

| File                            | Purpose                                                                                         |
| ------------------------------- | ----------------------------------------------------------------------------------------------- |
| `lua/config/lazy.lua`           | lazy.nvim bootstrap + LazyVim integration, performance settings                                 |
| `lua/config/options.lua`        | Core vim options (signcolumn, virtualedit, fillchars, python LSP choice)                        |
| `lua/config/keymaps.lua`        | All custom normal/visual/terminal keybindings                                                   |
| `lua/utils.lua`                 | fast_save, diagnostic_goto, qf_from_cmd, pprint, local_plugin, jump_location, open_repo_actions |
| `lua/plugins/disabled.lua`      | Explicitly disabled LazyVim default plugins                                                     |
| `colors/covid19.lua`            | Custom lush.nvim colorscheme (HSL definitions, treesitter + LSP diagnostic highlights)          |
| `lazyvim.json`                  | LazyVim extras list (copilot, mini-surround, neo-tree, biome, python, typescript, zig, etc.)    |
| `after/ftplugin/python.lua`     | Python-specific mappings + QF commands                                                          |
| `after/ftplugin/typescript.lua` | TypeScript-specific QF commands                                                                 |

## What to Avoid

- **Do not re-enable** `bufferline.nvim`, `lualine.nvim`, `flash.nvim`, `gitsigns.nvim`,
  or `venv-selector.nvim` without discussion.
- **Do not change** `vim.g.lazyvim_python_lsp` away from `"pyrefly"` unless there's a strong reason.
- **Avoid adding heavy startup-time plugins** without lazy-loading —
  the config sets `lazy = false` by default for custom plugins.
- **Do not delete** `lua/utils.lua` functions without checking cross-references in ftplugins
  and plugin configs.

## Notes

- **LazyVim extras enabled** (`lazyvim.json`): `ai.copilot`, `coding.mini-surround`,
  `editor.neo-tree`, `formatting.biome`, `lang.ansible`, `lang.json`, `lang.python`, `lang.sql`,
  `lang.toml`, `lang.typescript`, `lang.yaml`, `lang.zig`, `ui.mini-starter`.
- **Copilot integration**: Uses `zbirenbaum/copilot.lua` (not the default LazyVim copilot extra
  directly).
  Suggestion keymaps: `<C-n>` next, `<C-p>` prev, `<C-e>` dismiss.
  Accept is disabled (managed by `blink-cmp`).
- **LSP server configs**: `lua/plugins/lsp/servers/lua_ls.lua`
  and `common.lua` hold server-specific settings.
- **Custom fillchars** set in `options.lua` give a classic vim aesthetic (`foldopen = "-"`,
  `foldclose = "+",`eob = "~"`).
- **No `.cursorrules` or `CLAUDE.md`** found in this workspace.
- **Dotfiles context**: This is part of a personal dotfiles repo managed with GNU Stow.
  See repo-root `AGENTS.md` for global conventions.
