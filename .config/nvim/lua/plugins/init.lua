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

  -- use(require "plugins/local")

  -- Dashboard, comments, pairs, statusline, cursorword
  use {
    "ahmedkhalf/project.nvim",
    config = require "configs/project",
  }
  use {
    "echasnovski/mini.nvim",
    config = function()
      require "configs/mini"
    end,
  }
  use {
    "simrat39/symbols-outline.nvim",
    config = require "configs/symbols-outline",
    cmd = {
      "SymbolsOutline",
      "SymbolsOutlineOpen",
      "SymbolsOutlineClose",
    },
  }
  use {
    "wfxr/minimap.vim",
    config = require "configs/minimap",
    -- cmd = {
    --   "Minimap",
    --   "MinimapClose",
    --   "MinimapToggle",
    --   "MinimapRefresh",
    --   "MinimapUpdateHighlight",
    -- },
    run = "cargo install --locked code-minimap",
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

  -- Fuzzy finder and it requirments.
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "configs/telescope"
    end,
  }
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    requires = { "nvim-lua/plenary.nvim" },
  }
  use "artart222/telescope_find_directories"
  use {
    "mrjones2014/dash.nvim",
    run = "make install",
  }

  -- File explorer tree.
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = {
      "NvimTreeOpen",
      "NvimTreeFocus",
      "NvimTreeToggle",
      "NvimTreeFindFile",
    },
    config = function()
      require "configs/nvim-tree"
    end,
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
