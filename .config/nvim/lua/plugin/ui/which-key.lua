-- WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
-- https://github.com/folke/which-key.nvim
return {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup {
      plugins = {
        registers = false,
      },
      operators = {
        gc = "Comments",
        ys = "Surround",
        Q = "Format",
      },
    }
  end,
}