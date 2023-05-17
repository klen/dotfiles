-- Apprentice color scheme for Neovim written in Lua
-- https://github.com/adisen99/apprentice.nvim
return {
  "adisen99/apprentice.nvim",
  dependencies = { "rktjmp/lush.nvim" },
  init = function()
    vim.g.apprentice_contrast_dark = "hard" -- hard|medium|soft
  end,
}
