vim.pack.add {
  'https://github.com/klen/nvim-test'
}

local test = require 'nvim-test'

-- Configure nvim-test with custom terminal options
test.setup {
  termOpts = {
    width = function() return math.max(math.ceil(vim.o.columns * 0.35), 40) end, -- Terminal width: 35% of columns or min 40
  },
}

-- Set up keybindings for nvim-test commands
local map = vim.keymap.set

map('n', '<leader>t', "", { desc = '+test' })
map('n', '<leader>tn', "<cmd>TestNearest<cr>", { desc = "Run the nearest test" })
map('n', '<leader>tf', "<cmd>TestFile<cr>", { desc = "Run all tests in current file" })
map('n', '<leader>tl', "<cmd>TestLast<cr>", { desc = "Run the last executed test" })
map('n', '<leader>tt', "<cmd>TestSuite<cr>", { desc = "Run the entire test suite" })
map('n', '<leader>tv', "<cmd>TestVisit<cr>", { desc = "Visit the last test file" })
map('n', '<leader>te', "<cmd>TestEdit<cr>", { desc = "Edit tests (if supported by runner)" })

-- Set up an autocommand to close the test output buffer with 'q'
local utils = require('utils')

vim.api.nvim_create_autocmd('FileType', {
  group = utils.autogroup('test'),
  pattern = 'nvim-test',
  callback = function()
    vim.keymap.set('n', 'q', "<cmd>close<cr>", { buffer = true, desc = "Close test output" })
  end,
})
