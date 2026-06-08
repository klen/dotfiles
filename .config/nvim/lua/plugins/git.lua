vim.pack.add {
  'https://github.com/tpope/vim-fugitive'
}

-- Set up keybindings for git commands
local map = vim.keymap.set

map('n', '<leader>g', '', { desc = '+git' })
map('n', '<leader>gs', function()
  vim.cmd('above Git')
  vim.cmd('resize 18')
end, { desc = 'Git status' })
map('n', '<leader>gd', ':Gdiffsplit<CR>', { desc = 'Git diff' })
map('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
map('n', '<leader>gh', ':Git browse<CR>', { desc = 'Git browse' })

-- Set up an autocommand to close the fugitive buffer with 'q'
local utils = require('utils')

vim.api.nvim_create_autocmd('FileType', {
  group = utils.autogroup('git'),
  pattern = 'fugitive',
  callback = function()
    vim.opt_local.bufhidden = 'delete'
    vim.keymap.set('n', 'q', "<cmd>close<cr>", { buffer = true, desc = "Close test output" })
  end,
})
