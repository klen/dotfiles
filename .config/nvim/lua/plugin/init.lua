-- Disable some builtin vim plugins
local g = vim.g

g.loaded_2html_plugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logipat = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_matchit = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_rrhelper = 1
g.loaded_spellfile_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1

require("plugin.packer").startup(function(use)
  use "wbthomason/packer.nvim"

  -- Speed up nvim require and startup time
  use { "lewis6991/impatient.nvim" }

  -- Lua/plugins helpers (must be installed)
  use "nvim-lua/plenary.nvim"

  -- TreeSitter (syntax, folding)
  use {
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
      "nvim-treesitter/playground",
      cmd = {
        "TSPlaygroundToggle",
        "TSHighlightCapturesUnderCursor",
      },
    },
  }

  -- LSP (autocomplete, code browsing, diagnostic)
  use(require "plugin/lsp")

  -- UI
  use(require "plugin/ui")

  -- Dashboard, pairs, statusline, cursorword
  use(require "plugin/mini")

  -- Code (Syntax/Completion/Snippets/Languages)
  use(require "plugin/code")

  -- Color schemes.
  use(require "plugin/colors")

  -- Rest client
  use "NTBBloodbath/rest.nvim"

  -- Local plugins (in development)
  local tools = require "tools"

  -- Local configs
  use {
    tools.local_plugin("~/projects/nvim/config-local", "klen/nvim-config-local"),
    config = function()
      require("config-local").setup()
    end,
  }

  -- Run code/repl
  use {
    "~/projects/nvim/runner",
    config = function()
      require("runner").setup()
    end,
  }
end)
