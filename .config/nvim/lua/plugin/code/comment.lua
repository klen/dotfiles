-- Smart and powerful comment plugin for neovim
-- https://github.com/numToStr/Comment.nvim
return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()
  end,
}
