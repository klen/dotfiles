-- Auto completion support

return {
  require "plugin/completion/luasnip",
  require "plugin/completion/cmp",
  {
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-nvim-lua",
    after = "cmp-nvim-lsp",
  },
  {
    "hrsh7th/cmp-buffer",
    after = "cmp-nvim-lsp",
  },
  {
    "hrsh7th/cmp-path",
    after = "cmp-buffer",
  },
  -- use {"hrsh7th/cmp-cmdline", after = "cmp-path"}
}
