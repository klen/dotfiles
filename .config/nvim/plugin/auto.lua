local api = vim.api
local autocmd = api.nvim_create_autocmd

api.nvim_create_augroup("vimrc", { clear = true })

-- Only show cursorline in the current window and in normal mode.
autocmd({ "WinLeave", "InsertEnter" }, {
  pattern = "*",
  command = "set nocursorline",
  group = "vimrc",
})
autocmd({ "WinEnter", "InsertLeave" }, {
  pattern = "*",
  command = "set cursorline",
  group = "vimrc",
})

-- Unset paste on InsertLeave
autocmd({ "InsertLeave" }, {
  pattern = "*",
  command = "silent! set nopaste",
  group = "vimrc",
})

-- Terminal
autocmd({ "TermOpen" }, {
  pattern = "*",
  command = "startinsert | setlocal nonumber norelativenumber",
  group = "vimrc",
})

-- Highlight yank (something doesnt work)
-- TODO: Disabled because an error in Nvim 7
-- autocmd({ "TextYankPost" }, {
--   pattern = "*",
--   callback = function()
--     vim.highlight.on_yank { higroup = "IncSearch", timeout = 50, on_visual = false }
--   end,
-- })

-- Restore cursor position
autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.fn.line "'\"" <= vim.fn.line "$" then
      vim.cmd 'normal! g`"'
    end
  end,
  group = "vimrc",
})

-- Files
autocmd("BufWritePre", {
  pattern = { "/tmp/*", "COMMIT_EDITMSG", "MERGE_MSG", "*.tmp", "*.bak" },
  command = "setlocal noundofile",
  group = "vimrc",
})

autocmd({ "BufRead" }, {
  pattern = ".vimrc.lua",
  command = "set ft=lua",
  group = "vimrc",
})
