return function()
  vim.g.scrollview_column = 1
  vim.g.scrollview_current_only = 0
  vim.g.scrollview_excluded_filetypes = { "starter", "NvimTree", "packer"}
  vim.g.scrollview_refresh_time = 200
end
