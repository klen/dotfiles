-- Neovim plugin to improve the default vim.ui interfaces
-- https://github.com/stevearc/dressing.nvim
return {
  "stevearc/dressing.nvim",
  config = function()
    require("dressing").setup {
      select = {
        telescope = {
          theme = "cursor",
        },
      },
    }
  end,
}
