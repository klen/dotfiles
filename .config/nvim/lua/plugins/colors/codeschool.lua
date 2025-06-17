-- Codeschool colorscheme for neovim written in lua with treesitter and built-in lsp support
-- https://github.com/adisen99/codeschool.nvim
return {
  "adisen99/codeschool.nvim",
  lazy = true,
  dependencies = { "rktjmp/lush.nvim" },
  init = function()
    vim.g.codeschool_contrast_dark = "hard" -- hard|medium|soft
  end,
}
