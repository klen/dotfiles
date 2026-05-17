vim.pack.add {
  'https://github.com/esmuellert/codediff.nvim',
  'https://github.com/neogitorg/neogit'
}

local neogit = require('neogit')

neogit.setup {
  graph_style = 'unicode',
  kind = 'split_above',
  log_view = {
    kind = 'split',
  }
}

vim.keymap.set('n', '<leader>gs', neogit.open, { desc = 'Open Neogit' })
vim.keymap.set('n', '<leader>gl', '<cmd>NeogitLog<cr>', { desc = 'Open Neogit log' })
