-- Auto completion support

return {

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    requires = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip/loaders/from_vscode").lazy_load()
    end,
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    config = require "plugin/completion/config",
  },

  -- Completion engine plugins
  "hrsh7th/cmp-buffer", -- Buffer completion
  "hrsh7th/cmp-path", -- Path completion
  "hrsh7th/cmp-nvim-lsp", -- LSP completion
  "hrsh7th/cmp-nvim-lua", -- VIM lua API completion
  "saadparwaiz1/cmp_luasnip", -- Snippets completion

  -- use {"hrsh7th/cmp-cmdline", after = "cmp-path"}
}
