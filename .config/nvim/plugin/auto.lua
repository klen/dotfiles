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

-- Terminal
autocmd({ "TermOpen" }, {
  pattern = "*",
  command = "startinsert | setlocal nonumber norelativenumber",
  group = "vimrc",
})

-- Highlight on yank
-- disabled because of errors
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   group = "vimrc",
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })

-- Restore cursor position
autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    pcall(function()
      local pos = vim.fn.line "'\""
      if pos > 0 and pos <= vim.fn.line "$" then
        vim.cmd [[normal! g`"zz]]
      end
    end)
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
