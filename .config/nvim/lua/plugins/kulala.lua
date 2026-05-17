vim.pack.add {
  'https://github.com/mistweaverco/kulala.nvim'
}

require("kulala").setup {
  global_keymaps = true,
  global_keymaps_prefix = '<leader>h',
  -- Optional: Set the theme to 'dark' or 'light'
  theme = 'dark',
}

vim.keymap.set('n', '<leader>h', '', { desc = "+http" })
