local utils = require("utils")
local api = vim.api
local autocmd = api.nvim_create_autocmd

-- Highlight yanked text for a brief moment
autocmd('TextYankPost', {
  group = utils.autogroup('config'),
  callback = function() vim.highlight.on_yank() end
})

-- Restore the last cursor position when reopening a file
autocmd('BufReadPost', {
  group = utils.autogroup('config'),
  callback = function()
    local mark = api.nvim_buf_get_mark(0, '"')
    local line_count = api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- When a terminal buffer is opened, automatically enter insert mode
-- and disable line numbers for a cleaner terminal experience.
autocmd({ "TermOpen" }, {
  group = utils.autogroup('config'),
  pattern = "*",
  command = "startinsert | setlocal nonumber norelativenumber",
})

-- For some buffers, make them unlisted and set up a convenient keybinding to close them.
autocmd({ "FileType" }, {
  group = utils.autogroup('config'),
  pattern = {
    'help', 'qf', 'checkhealth', 'nvim-pack', 'nvim-undotree', 'log'
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end
})

--- Cursor and UI Enhancements ---
-- Only show cursorline in the current window and when in Normal mode.
-- This reduces visual noise and helps focus on the active area.
autocmd({ "WinLeave", "InsertEnter", "FocusLost" }, {
  group = utils.autogroup('config'),
  pattern = "*",
  command = "set nocursorline",
})
autocmd({ "WinEnter", "InsertLeave", "FocusGained" }, {
  group = utils.autogroup('config'),
  pattern = "*",
  command = "set cursorline",
})
