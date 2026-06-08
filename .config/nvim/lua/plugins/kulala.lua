vim.pack.add {
  'https://github.com/mistweaverco/kulala.nvim'
}

---@diagnostic disable-next-line: different-requires
require("kulala").setup {
  global_keymaps = true,
  global_keymaps_prefix = '<leader>h',
  ui = {
    max_response_size = 5 * 1024 * 1024, -- 5MB
  },
  lsp = {
    enable = false
  }
}

vim.keymap.set('n', '<leader>h', '', { desc = "+http" })
