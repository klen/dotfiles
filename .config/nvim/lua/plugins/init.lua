-- Auto install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

-- Disable some plugins
require "plugins/disable"

-- Setup plugins
return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Speed up nvim require and startup time
  use "lewis6991/impatient.nvim"

  -- Tools
  use(require "plugins/tools")

  -- LSP (autocomplete, code browsing, diagnostic)
  use(require "plugins/lsp")

  -- TreeSitter (syntax, folding)
  use(require "plugins/treesiter")

  -- Completion / Snippets
  use(require "plugins/completion")

  -- Local plugins
  use {
    "~/.config/nvim/lua/plugins/local/runner",
    config = function()
      require("runner").setup()
    end,
  }

  -- Explore files/symbols/buffers/etc
  use(require "plugins/explore")

  -- Dashboard, comments, pairs, statusline, cursorword
  use {
    "echasnovski/mini.nvim",
    config = function()
      require "configs/mini"
    end,
  }
  use {
    "dstein64/nvim-scrollview",
    config = require "configs/scrollview",
  }

  -- Statusline.
  -- use {
  --   "nvim-lualine/lualine.nvim",
  --   config = function ()
  --     require("configs/lualine")
  --   end
  -- }

  -- Run tests
  use {
    "vim-test/vim-test",
    config = require "configs/vim-test",
  }

  -- Languages Support
  use(require "plugins/languages")

  -- Color schemes.
  use(require "plugins/colors")

  -- Rest client
  use {
    "NTBBloodbath/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = require "configs/rest",
  }

  -- Git support
  use "tpope/vim-fugitive"

  -- TODO
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup { signcolumn = false }
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
