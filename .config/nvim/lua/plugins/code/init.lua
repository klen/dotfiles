local tools = require "tools"

return {

  -- Copilot
  {
    "github/copilot.vim",
    build = ":Copilot auth",
    config = function()
      vim.keymap.set("i", "<M-l>", "<cmd>:Copilot<cr>")
    end,
  },

  -- Repeat surround motions with .
  "tpope/vim-surround",
  "tpope/vim-repeat",

  -- Comment code
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Tests
  tools.local_plugin("~/projects/nvim/test", "klen/nvim-test", {
    keys = { "<leader>tn", "<leader>tf", "<leader>tl", "<leader>tt", "<leader>tv", "<leader>te" },
    config = function()
      local test = require "nvim-test"

      test.setup {
        termOpts = {
          width = math.max(math.ceil(vim.o.columns * 0.35), 40),
        },
      }

      local wk = require "which-key"
      wk.register {
        ["<leader>tn"] = { "<cmd>TestNearest<cr>", "Run the nearest test" },
        ["<leader>tf"] = { "<cmd>TestFile<cr>", "Run the file" },
        ["<leader>tl"] = { "<cmd>TestLast<cr>", "Run the last test" },
        ["<leader>tt"] = { "<cmd>TestSuite<cr>", "Run all tests" },
        ["<leader>tv"] = { "<cmd>TestVisit<cr>", "Visit the last test" },
        ["<leader>te"] = { "<cmd>TestEdit<cr>", "Edit tests" },
      }
    end,
  }),

  -- Snippets
  require "plugins/code/luasnip",

  -- Completion
  require "plugins/code/nvim-cmp",

  -- Python
  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python" },
  },

  -- CoffeeScript
  "kchmck/vim-coffee-script",

  -- Git support
  require "plugins/code/git",

  -- Rest client
  -- require "plugins/code/rest",

  -- Local plugins (in development)
  tools.local_plugin("~/projects/nvim/config-local", "klen/nvim-config-local", {
    config = function()
      require("config-local").setup { lookup_parents = true }
    end,
  }),

  -- Run code/repl
  {
    dir = "~/projects/nvim/runner",
    config = function()
      require("runner").setup()
    end,
  },
}
