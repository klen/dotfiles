local cfg = require "config"
vim.opt.background = cfg.background

return {
  -- Define Neovim themes as a DSL in lua
  require "plugins/colorschemes/lush",

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

  require "plugins/colorschemes/apprentice",
  require "plugins/colorschemes/codeschool",
  require "plugins/colorschemes/material",
  require "plugins/colorschemes/nordic",
  require "plugins/colorschemes/tokyonight",
  require "plugins/colorschemes/vscode",
}
