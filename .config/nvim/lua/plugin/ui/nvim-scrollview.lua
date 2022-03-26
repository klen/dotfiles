-- A Neovim plugin that displays interactive vertical scrollbars.
-- https://github.com/dstein64/nvim-scrollview
return {
  "dstein64/nvim-scrollview",
  config = function()
    vim.g.scrollview_column = 1
    vim.g.scrollview_current_only = 0
    vim.g.scrollview_excluded_filetypes = {
      "starter",
      "NvimTree",
      "packer",
      "SidebarNvim",
      "Outline",
    }
    vim.g.scrollview_refresh_time = 200
  end,
}
