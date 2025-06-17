local api = vim.api
local autocmd = api.nvim_create_autocmd

api.nvim_create_augroup("vimrc", { clear = true })

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  group = "vimrc",
})

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

-- Terminal
autocmd({ "TermOpen" }, {
  pattern = "*",
  command = "startinsert | setlocal nonumber norelativenumber",
  group = "vimrc",
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({
      higroup = "TermCursor",
    })
  end,
  group = "vimrc",
})

-- Restore cursor position
autocmd("BufWinEnter", {
  pattern = "*",
  callback = function(event)
    local bn = event.buf
    local buf = vim.b[bn]
    if buf.filetype == "gitcommit" or buf.lastloc then
      return
    end
    buf.lastloc = true
    local mark = api.nvim_buf_get_mark(bn, '"')
    local lcount = api.nvim_buf_line_count(bn)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
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
