local tools = require "tools"

return {

  require "plugins/code/treesitter",

  -- Comment code
  {
    "numToStr/Comment.nvim",
    opts = {},
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
      wk.add {
        { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Run the nearest test" },
        { "<leader>tf", "<cmd>TestFile<cr>",    desc = "Run the file" },
        { "<leader>tl", "<cmd>TestLast<cr>",    desc = "Run the last test" },
        { "<leader>tt", "<cmd>TestSuite<cr>",   desc = "Run all tests" },
        { "<leader>tv", "<cmd>TestVisit<cr>",   desc = "Visit the last test" },
        { "<leader>te", "<cmd>TestEdit<cr>",    desc = "Edit tests" },
      }
    end,
  }),

  -- Copilot
  require "plugins/code/copilot-vim",
  -- require "plugins/code/copilot",

  -- Snippets
  -- require "plugins/code/luasnip",

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
  require "plugins/code/luarocks",
  require "plugins/code/rest",

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

  -- require "plugins/code/avante",
}
