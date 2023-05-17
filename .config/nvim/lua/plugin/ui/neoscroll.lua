-- Smooth scrolling neovim plugin written in lua
-- https://github.com/karb94/neoscroll.nvim
return {
  "karb94/neoscroll.nvim",
  -- Configure
  config = function()
    require("neoscroll").setup()
  end,
}
