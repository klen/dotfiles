local tools = require "tools"

return {

  -- Repeat surround motions with .
  "tpope/vim-surround",
  "tpope/vim-repeat",

  -- Comment code
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {}
    end,
  },

  -- Git support
  "lewis6991/gitsigns.nvim",
  {
    "tpope/vim-fugitive",
    setup = function()
      local cfg = require "config"
      cfg.keymaps["<leader>ga"] = { "<cmd>Gwrite<cr>", "Git add" }
      cfg.keymaps["<leader>gb"] = { "<cmd>Git blame<cr>", "Git blame" }
      cfg.keymaps["<leader>gd"] = { "<cmd>Gdiffsplit<cr>", "Git diff" }
      cfg.keymaps["<leader>gs"] = { "<cmd>abo Git<cr>", "Git status" }
      cfg.keymaps["<leader>gr"] = { "<cmd>Gdelete<cr>", "Git remove" }
      cfg.keymaps["<leader>gp"] = { "<cmd>Git push<cr>", "Git push all" }
      cfg.keymaps["<leader>gc"] = { "<cmd>Git commit %<cr>", "Git commit" }
    end,
  },

  -- Tests
  tools.local_plugin("~/projects/nvim/test", "klen/nvim-test"),

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    requires = { "rafamadriz/friendly-snippets" },
  },

  -- Completion
  "hrsh7th/nvim-cmp", -- completion engine
  "hrsh7th/cmp-buffer", -- Buffer completion
  "hrsh7th/cmp-path", -- Path completion
  "hrsh7th/cmp-nvim-lsp", -- LSP completion
  "hrsh7th/cmp-nvim-lua", -- VIM lua API completion
  "saadparwaiz1/cmp_luasnip", -- Snippets completion

  -- Python
  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python" },
  },

  -- CoffeeScript
  "kchmck/vim-coffee-script",
}
