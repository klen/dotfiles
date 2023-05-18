local cfg = require "config"
vim.opt.background = cfg.background

return {
  -- Define Neovim themes as a DSL in lua
  require "plugins/theme/lush",

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
    lazy = true,
  },

  require "plugins/theme/apprentice",
  require "plugins/theme/codeschool",
  require "plugins/theme/material",
  require "plugins/theme/nordic",
  require "plugins/theme/tokyonight",
  require "plugins/theme/vscode",
}
