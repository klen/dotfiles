-- A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.
-- https://github.com/folke/tokyonight.nvim
return {
  "folke/tokyonight.nvim",
  init = function()
    vim.g.tokyonight_style = "night" -- night|day|storm
    vim.g.tokyonight_italic_comments = false
    vim.g.tokyonight_italic_keywords = false
  end,
}
