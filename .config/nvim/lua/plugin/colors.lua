local cfg = require "config"
vim.opt.background = cfg.background

local plugins = {
  -- Tools
  {
    "rktjmp/lush.nvim",
    config = function()
      -- Lushify
      vim.cmd [[
        augroup packer_user_config
          autocmd!
          autocmd BufEnter **/colors/*.lua Lushify
        augroup end
      ]]
    end,
  },

  -- Colorschemes
  "ray-x/aurora",
  "kyazdani42/blue-moon",
  "EdenEast/nightfox.nvim",
  "sainnhe/sonokai",
  {
    "nanotech/jellybeans.vim",
    opt = true,
  },
  {
    "mcchrish/zenbones.nvim",
    requires = { "rktjmp/lush.nvim" },
  },
}

-- vscode
table.insert(plugins, "Mofiqul/vscode.nvim")
g.vscode_style = cfg.background

-- material
table.insert(plugins, "marko-cerovac/material.nvim")
g.material_style = "darker" -- darker|palenight|oceanic|lighter|deep ocean

-- tokyonight
table.insert(plugins, "folke/tokyonight.nvim")
g.tokyonight_style = "night" -- night|day|storm
g.tokyonight_italic_comments = false
g.tokyonight_italic_keywords = false

-- nordbuddy
table.insert(plugins, "maaslalani/nordbuddy")
g.nord_underline_option = "none"
g.nord_italic = true
g.nord_italic_comments = false
g.nord_minimal_mode = false

-- gruvbox-material
table.insert(plugins, "sainnhe/gruvbox-material")
g.gruvbox_material_background = "hard" -- hard|medium|soft
g.gruvbox_material_disable_italic_comment = true
g.gruvbox_material_transparent_background = true

-- apprentice
table.insert(plugins, {
  "adisen99/apprentice.nvim",
  requires = { "rktjmp/lush.nvim" },
})
g.apprentice_contrast_dark = "hard" -- hard|medium|soft

-- codeschool
table.insert(plugins, {
  "adisen99/codeschool.nvim",
  requires = { "rktjmp/lush.nvim" },
})
vim.g.codeschool_contrast_dark = "hard" -- hard|medium|soft

return plugins
