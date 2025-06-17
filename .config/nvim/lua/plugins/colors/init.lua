local cfg = require "config"
vim.opt.background = cfg.background

return {
  -- Define Neovim themes as a DSL in lua
  require "plugins/colors/lush",

  -- Colorschemes
  require "plugins/colors/jellybeans",
  require "plugins/colors/zenbones",
  require "plugins/colors/codeschool",
  require "plugins/colors/tokyonight",
  require "plugins/colors/vscode",

  -- Support LSP colors
  "folke/lsp-colors.nvim",
}
