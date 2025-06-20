local api = vim.api
local autocmd = api.nvim_create_autocmd

-- Create an autocommand group to keep things organized and clear it on reload
api.nvim_create_augroup("vimrc", { clear = true })

--- File Management Autocommands ---
-- Check if a file needs reloading when Vim regains focus or a terminal closes/leaves.
-- This ensures you're always working with the latest version of the file if it changed externally.
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  callback = function()
    -- Only apply to regular files, not special buffer types like help or quickfix
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime") -- Check if the file has been modified outside Vim
    end
  end,
  group = "vimrc",
})

-- Disable undo file for specific temporary or commit-related files.
-- This prevents cluttering your undo history with non-essential changes.
autocmd("BufWritePre", {
  pattern = { "/tmp/*", "COMMIT_EDITMSG", "MERGE_MSG", "*.tmp", "*.bak" },
  command = "setlocal noundofile",
  group = "vimrc",
})

-- Set filetype for specific configuration files if not automatically detected
autocmd({ "BufRead" }, {
  pattern = ".vimrc.lua",
  command = "set ft=lua", -- Force filetype to Lua for .vimrc.lua
  group = "vimrc",
})


--- Cursor and UI Enhancements ---
-- Only show cursorline in the current window and when in Normal mode.
-- This reduces visual noise and helps focus on the active area.
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

-- Briefly highlight text after yanking (copying) it.
-- This provides visual feedback for the yank operation.
autocmd("TextYankPost", {
  callback = function()
    -- `vim.hl.on_yank` is a built-in helper for this.
    -- `higroup` specifies the highlight group to use (TermCursor for example).
    vim.hl.on_yank({
      higroup = "TermCursor",
    })
  end,
  group = "vimrc",
})

-- Restore cursor position when entering a buffer.
-- This is super handy for picking up where you left off in a file.
autocmd("BufWinEnter", {
  pattern = "*",
  callback = function(event)
    local bn = event.buf
    local buf = vim.b[bn] -- Get buffer-local variables for current buffer

    -- Skip if it's a git commit message or if position has already been restored
    if buf.filetype == "gitcommit" or buf.lastloc then
      return
    end

    buf.lastloc = true                          -- Mark that position has been restored for this buffer
    local mark = api.nvim_buf_get_mark(bn, '"') -- Get the last known cursor position ('' mark)
    local lcount = api.nvim_buf_line_count(bn)  -- Get total lines in buffer

    -- Restore cursor if the stored position is valid within the buffer's lines
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark) -- Safely set cursor position
    end
  end,
  group = "vimrc",
})


--- Terminal-Specific Autocommands ---
-- When a terminal buffer is opened, automatically enter insert mode
-- and disable line numbers for a cleaner terminal experience.
autocmd({ "TermOpen" }, {
  pattern = "*",
  command = "startinsert | setlocal nonumber norelativenumber",
  group = "vimrc",
})
