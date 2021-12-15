local mode = "dark"
local config = {}

cmd("set background=" .. mode)

table.insert(config, {
  "nanotech/jellybeans.vim",
  opt = true,
})
table.insert(config, "kyazdani42/blue-moon")
table.insert(config, "EdenEast/nightfox.nvim")

table.insert(config, "Mofiqul/vscode.nvim")
g.vscode_style = mode

table.insert(config, "marko-cerovac/material.nvim")
g.material_style = "darker" -- darker|palenight|oceanic|lighter|deep ocean

table.insert(config, "folke/tokyonight.nvim")
g.tokyonight_style = "night" -- night|day|storm
g.tokyonight_italic_comments = false
g.tokyonight_italic_keywords = false

table.insert(config, "maaslalani/nordbuddy")
g.nord_underline_option = "none"
g.nord_italic = true
g.nord_italic_comments = false
g.nord_minimal_mode = false

table.insert(config, "sainnhe/gruvbox-material")
g.gruvbox_material_background = "hard" -- hard|medium|soft
g.gruvbox_material_disable_italic_comment = true
g.gruvbox_material_transparent_background = true

table.insert(config, "sainnhe/sonokai")
g.sonokai_style = "default" -- default, atlantis, andromeda, shusia, maia, espresso

table.insert(config, {
  "adisen99/apprentice.nvim",
  requires = { "rktjmp/lush.nvim" },
})
g.apprentice_contrast_dark = "hard" -- hard|medium|soft

table.insert(config, {
  "mcchrish/zenbones.nvim",
  requires = { "rktjmp/lush.nvim" },
})

table.insert(config, {
  "adisen99/codeschool.nvim",
  requires = { "rktjmp/lush.nvim" },
})
g.codeschool_contrast_dark = "hard" -- hard|medium|soft

-- Lushify
cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufEnter **/.config/nvim/lua/colors/*.lua Lushify
  augroup end
]]

return config
