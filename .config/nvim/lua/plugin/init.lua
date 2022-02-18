-- Disable some plugins
require "plugin.disabled"

require("plugin.packer").startup(function(use)
  use "wbthomason/packer.nvim"

  -- Speed up nvim require and startup time
  use { "lewis6991/impatient.nvim" }
  use {
    "nathom/filetype.nvim",
    setup = function()
      vim.g.did_load_filetypes = 1
    end,
  }

  -- Tools
  use {
    -- Better loclist/qflist
    require "plugin/nvim-bfq",

    -- Better scrolling
    require "plugin/neoscroll",
    require "plugin/nvim-scrollview",

    -- {
    --   "rinx/nvim-minimap",
    --   config = function()
    --     vim.g["minimap#window#height"] = vim.api.nvim_win_get_height(0)
    --   end,
    -- },

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

    -- Toggle terminal
    require "plugin/toggle-term",

    -- indent guides
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent_blankline").setup {
          use_treesitter = true,
          show_first_indent_level = false,
          filetype_exclude = { "", "help", "packer", "starter" },
        }
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

    -- {
    --   "GustavoKatel/sidebar.nvim",
    --   config = function()
    --     require("sidebar-nvim").setup { open = true, side = "right" }
    --   end,
    -- },
  }

  -- Movements/Keys
  use {
    -- Show key/operators maps
    require "plugin/which-key",

    -- repeat surround motions with .
    "tpope/vim-surround",
    "tpope/vim-repeat",

    -- Movement
    -- {
    --   "booperlv/nvim-gomove",
    --   config = function()
    --     require("gomove").setup()
    --   end,
    -- },
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
  use(require "plugin.rest")

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

  -- Local plugins (in development)
  local path
  local home = os.getenv "HOME"

  -- Local configs
  path = home .. "/projects/nvim/config-local"
  use {
    (vim.fn.isdirectory(path) == 1) and path or "klen/nvim-config-local",
    config = function()
      require("config-local").setup()
    end,
  }

  -- Run tests
  path = home .. "/projects/nvim/test"
  use {
    (vim.fn.isdirectory(path) == 1) and path or "klen/nvim-test",
    config = function()
      require("nvim-test").setup()
    end,
  }

  -- Run code/repl
  use {
    "~/.config/nvim/lua/plugin/local/runner",
    config = function()
      require("runner").setup()
    end,
  }
end)
