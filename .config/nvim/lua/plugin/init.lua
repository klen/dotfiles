local plugins = require "plugin/packer"

-- Disable some plugins
require "plugin/disabled"

-- Setup plugins
return plugins.packer.startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Speed up nvim require and startup time
  use { "lewis6991/impatient.nvim", "nathom/filetype.nvim" }

  -- Tools
  use {
    -- Better loclist/qflist
    require "plugin/nvim-bfq",

    -- Better scrolling
    require "plugin/neoscroll",
    require "plugin/nvim-scrollview",

    -- Better notifies
    require "plugin/nvim-notify",

    -- Lua/plugins helpers
    "nvim-lua/plenary.nvim",

    -- UI Helpers (vim.ui.input, vim.ui.select)
    "stevearc/dressing.nvim",

    -- Clipboard helper
    {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("neoclip").setup()
      end,
    },
  }

  -- Explore files/symbols/buffers/etc
  use {
    -- Highly extendable fuzzy finder over lists
    require "plugin/telescope",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      run = "make",
    },
    {
      "mrjones2014/dash.nvim",
      run = "make install",
    },
    -- File explorer tree.
    require "plugin/nvim-tree",

    -- Code explorer
    require "plugin/symbols-outline",
  }

  -- Movements/Keys
  use {
    -- Show key/operators maps
    require "plugin/which-key",

    -- repeat surround motions with .
    "tpope/vim-surround",
    "tpope/vim-repeat",
  }

  -- Color schemes.
  use(require "plugin/colors")

  -- LSP (autocomplete, code browsing, diagnostic)
  use(require "plugin/lsp")

  -- TreeSitter (syntax, folding)
  use(require "plugin/treesiter")

  -- Completion / Snippets
  use(require "plugin/completion")

  -- Dashboard, pairs, statusline, cursorword
  use(require "plugin/mini")

  -- Statusline.
  -- use {
  --   "nvim-lualine/lualine.nvim",
  --   config = function ()
  --     require("setup/lualine")
  --   end
  -- }

  -- Codding
  use {
    -- Better Syntax
    "sheerun/vim-polyglot",

    -- Run tests
    require "plugin/vim-test",

    -- Commenting
    require "plugin/comment",

    -- Python
    {
      "Vimjas/vim-python-pep8-indent",
      ft = { "python" },
    },

    -- CoffeeScript
    "kchmck/vim-coffee-script",
  }

  -- Rest client
  use(require "plugin/rest")

  -- Git support
  use {
    "tpope/vim-fugitive",
    {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("gitsigns").setup { signcolumn = false }
      end,
    },
  }

  -- Local plugins
  use {
    "~/.config/nvim/lua/plugin/local/runner",
    config = function()
      require("runner").setup()
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if plugins.first_install then
    plugins.packer.sync()
  end
end)
