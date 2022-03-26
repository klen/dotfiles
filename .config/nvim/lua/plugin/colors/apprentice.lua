-- Apprentice color scheme for Neovim written in Lua
-- https://github.com/adisen99/apprentice.nvim
return {
  "adisen99/apprentice.nvim",
  requires = { "rktjmp/lush.nvim" },
  setup = function()
    vim.g.apprentice_contrast_dark = "hard" -- hard|medium|soft
  end,
}
