local cfg = require "config"
vim.opt.background = cfg.background

return {
  -- Define Neovim themes as a DSL in lua
  require "plugin/colors/lush",

  -- Colorschemes
  "ray-x/aurora",
  "kyazdani42/blue-moon",
  "EdenEast/nightfox.nvim",
  "sainnhe/sonokai",
  {
    "nanotech/jellybeans.vim",
    lazy = true,
  },
  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },

  require "plugin/colors/apprentice",
  require "plugin/colors/codeschool",
  require "plugin/colors/material",
  require "plugin/colors/nordic",
  require "plugin/colors/tokyonight",
  require "plugin/colors/vscode",
}
