local tools = require "tools"

require("plugin.lazy").setup {

  -- TreeSitter (syntax, folding)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSPlaygroundToggle",
      "TSHighlightCapturesUnderCursor",
    },
  },

  -- LSP (autocomplete, code browsing, diagnostic)
  require "plugin/lsp",

  -- UI
  require "plugin/ui",

  -- Dashboard, pairs, statusline, cursorword
  require "plugin/mini",

  -- Code (Syntax/Completion/Snippets/Languages)
  require "plugin/code",

  -- Color schemes
  require "plugin/colors",

  -- Rest client
  "NTBBloodbath/rest.nvim",

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
