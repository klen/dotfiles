vim.pack.add {
  'https://github.com/folke/snacks.nvim'
}

local snacks = require "snacks"

snacks.setup {
  picker = require('plugins.snacks.picker'),       -- A fuzzy finder for Neovim's built-in pickers
  bigfile = require('plugins.snacks.bigfile'),     -- Disable plugins and filetype detection for large files
  terminal = require('plugins.snacks.terminal'),   -- Toggle a terminal with <leader>t
  dashboard = require('plugins.snacks.dashboard'), -- A startup screen with a random header and some buttons
  indent = require('plugins.snacks.indent'),       -- Show indent lines
  toggle = require('plugins.snacks.toggle'),       -- Toggle options with <leader>to
  notifier = require('plugins.snacks.notifier'),   -- A notification manager
  scroll = {},                                     -- Smooth scrolling
}

local map = vim.keymap.set

map('n', '<leader>bd', function() snacks.bufdelete() end, { desc = 'Delete buffer' })

---@diagnostic disable-next-line: duplicate-set-field
vim._print = function(_, ...)
  snacks.debug.inspect(...)
end
