-- Snippet Engine for Neovim written in Lua
-- https://github.com/L3MON4D3/LuaSnip
return {
  "L3MON4D3/LuaSnip",
  requires = { "rafamadriz/friendly-snippets" },
  config = function()
    require("luasnip/loaders/from_vscode").lazy_load()
  end,
}
