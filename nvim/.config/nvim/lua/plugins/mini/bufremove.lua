local br = require('mini.bufremove')

-- Setup
br.setup {}

-- Keymaps
vim.keymap.set('n', '<leader>bd', br.delete, {desc = 'Delete buffer'})
vim.keymap.set('n', '<leader>bw', br.wipeout, {desc = 'Wipeout buffer'})
