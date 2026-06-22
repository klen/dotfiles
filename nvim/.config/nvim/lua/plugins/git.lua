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

-- Fugitive status buffer mappings (fires after full initialisation)
vim.api.nvim_create_autocmd('User', {
  pattern = 'FugitiveIndex',
  group = vim.api.nvim_create_augroup('git', { clear = true }),
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = true, desc = 'Close fugitive buffer' })
    -- Reuse fugitive-native mappings: 'o' = split, 'gO' = vsplit
    vim.keymap.set("n", "<C-s>", "o", { buffer = true, remap = true, desc = "Open in horizontal split" })
    vim.keymap.set("n", "<C-v>", "gO", { buffer = true, remap = true, desc = "Open in vertical split" })
  end,
})
