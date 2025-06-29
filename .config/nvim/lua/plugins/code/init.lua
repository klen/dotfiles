-- Import helper functions from the 'tools' module
local tools = require("tools")

return {
  -- Import the Treesitter configuration (likely from plugins/code/treesitter.lua)
  require("plugins/code/treesitter"),

  --- Code Commenting ---
  -- `folke/ts-comments.nvim`: Adds enhanced comment toggling using Treesitter.
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy", -- Load this plugin very late to minimize startup time
    opts = {},          -- No specific options configured here
  },

  --- Testing ---
  -- `klen/nvim-test`: A Neovim plugin for running tests.
  -- Uses `tools.local_plugin` to allow local development of this plugin.
  tools.local_plugin("~/projects/nvim/test", "klen/nvim-test", {
    -- Define keybindings that `which-key` will recognize and display.
    keys = { "<leader>tn", "<leader>tf", "<leader>tl", "<leader>tt", "<leader>tv", "<leader>te" },
    -- Configuration function for `nvim-test`. This runs after the plugin is loaded.
    config = function()
      local test = require("nvim-test")
      local wk = require("which-key") -- Assuming which-key is already loaded

      -- Setup `nvim-test` with a custom terminal width for test output.
      test.setup({
        termOpts = {
          width = math.max(math.ceil(vim.o.columns * 0.35), 40), -- Terminal width: 35% of columns or min 40
        },
      })

      -- Add `nvim-test` keymaps to `which-key` for easy discovery.
      wk.add({
        { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Run the nearest test" },
        { "<leader>tf", "<cmd>TestFile<cr>",    desc = "Run all tests in current file" },
        { "<leader>tl", "<cmd>TestLast<cr>",    desc = "Run the last executed test" },
        { "<leader>tt", "<cmd>TestSuite<cr>",   desc = "Run the entire test suite" },
        { "<leader>tv", "<cmd>TestVisit<cr>",   desc = "Visit the last test file" },
        { "<leader>te", "<cmd>TestEdit<cr>",    desc = "Edit tests (if supported by runner)" },
      })
    end,
  }),

  --- Language-Specific Support ---
  -- Python indenting based on PEP8.
  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python" }, -- Load only for Python files
  },
  -- CoffeeScript syntax highlighting and indentation.
  "kchmck/vim-coffee-script",

  --- Git Integration ---
  -- Import Git-related plugin configurations (likely from plugins/code/git.lua).
  require("plugins/code/git"),

  --- API/REST Client ---
  -- `luarocks` integration (likely for managing dependencies of Neovim plugins).
  require("plugins/code/luarocks"),
  -- REST client plugin configuration (likely from plugins/code/rest.lua).
  require("plugins/code/rest"),

  --- Local Plugin Development ---
  -- `klen/nvim-config-local`: Manages local (project-specific) Neovim configurations.
  -- Uses `tools.local_plugin` for local development.
  tools.local_plugin("~/projects/nvim/config-local", "klen/nvim-config-local", {
    config = function()
      -- Setup `nvim-config-local` to look for config files in parent directories.
      require("config-local").setup({ lookup_parents = true })
    end,
  }),

  --- Code Execution / REPL ---
  -- Local plugin for running code or launching REPLs.
  {
    dir = "~/projects/nvim/runner", -- Path to the local `runner` plugin directory
    config = function()
      require("runner").setup()     -- Initialize the runner plugin
    end,
  },

  --- Completion ---
  -- Custom completion setup using `blink-cmp`.
  -- `nvim-cmp` is commented out, suggesting `blink-cmp` is a replacement or custom wrapper.
  -- require "plugins/code/nvim-cmp",
  require("plugins/code/blink-cmp"),

  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {},
  },

  --- Other (Commented Out) ---
  -- The following line is commented out, indicating it's not currently active.
  -- require "plugins/code/avante",
}
