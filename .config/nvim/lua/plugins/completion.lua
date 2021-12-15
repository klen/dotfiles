-- Auto completion support

return {
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  },
  {
    "hrsh7th/nvim-cmp", -- Auto complete
    requires = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      require "setup/cmp"
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    config = function()
      require "setup/luasnip"
    end,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
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
