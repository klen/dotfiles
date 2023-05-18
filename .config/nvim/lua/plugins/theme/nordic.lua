-- A nord-esque colorscheme for neovim
-- https://github.com/andersevenrud/nordic.nvim
return {
  "andersevenrud/nordic.nvim",
  init = function()
    vim.g.nord_underline_option = "none"
    vim.g.nord_italic = true
    vim.g.nord_italic_comments = false
    vim.g.nord_minimal_mode = false
    vim.g.nord_alternate_backgrounds = false
  end,
}
