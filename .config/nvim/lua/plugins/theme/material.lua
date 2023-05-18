-- Material colorscheme for NeoVim written in Lua with built-in support for native LSP, TreeSitter and many more plugins
-- https://github.com/marko-cerovac/material.nvim
return {
  "marko-cerovac/material.nvim",
  init = function()
    vim.g.material_style = "darker" -- darker|palenight|oceanic|lighter|deep ocean
  end,
}
