vim.pack.add {
  'https://github.com/mistweaverco/kulala.nvim'
}

require("kulala").setup {
  global_keymaps = true,
  global_keymaps_prefix = '<leader>h',
  ui = {
    max_response_size = 1024 * 1024, -- 1MB
  },
  lsp = {
    enabled = false,
  }
}

vim.keymap.set('n', '<leader>h', '', { desc = "+http" })
