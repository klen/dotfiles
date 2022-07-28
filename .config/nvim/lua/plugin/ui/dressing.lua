-- Neovim plugin to improve the default vim.ui interfaces
-- https://github.com/stevearc/dressing.nvim
return {
  "stevearc/dressing.nvim",
  config = function()
    require("dressing").setup {
      input = {
        anchor = "NW",
        max_width = { 140, 0.9 },
        min_width = { 40, 0.6 },
      },
      -- select = {
      --   telescope = {
      --     theme = "cursor",
      --   },
      -- },
    }
  end,
}