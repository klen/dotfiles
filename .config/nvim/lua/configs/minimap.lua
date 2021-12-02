return function()
  vim.g.minimap_width = 10
  vim.g.minimap_auto_start = 1
  vim.g.minimap_auto_start_win_enter = 1
  vim.g.minimap_block_filetypes = { "starter", "NvimTree", "packer" }
  vim.g.minimap_close_filetypes = { "starter", "packer" }
end
