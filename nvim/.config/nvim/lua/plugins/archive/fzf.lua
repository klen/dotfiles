-- Install
vim.pack.add { "https://github.com/ibhagwan/fzf-lua" }

local fzf = require "fzf-lua"

-- Setup
fzf.setup {}

-- Keymaps
local map = vim.keymap.set
map('n', '<leader>f', '', { desc = "+find" }) -- Prefix for find commands

map("n", "<leader><leader>", function()
  fzf.files()
end, { desc = "Find files" })

map("n", "<leader>/", function()
  fzf.live_grep()
end, { desc = "Grep word" })

map("n", "<leader>fh", function()
  fzf.helptags()
end, { desc = "Find help tags" })

map("n", "<leader>fb", function()
  fzf.buffers()
end, { desc = "Find buffers" })

map("n", "<leader>fo", function()
  fzf.oldfiles()
end, { desc = "Find old files" })

map("n", "<leader>fr", function()
  fzf.resume()
end, { desc = "Resume last search" })

map("n", "<leader>fl", function()
  fzf.lsp_live_workspace_symbols()
end, { desc = "Find LSP symbols" })

map('n', '<leader>fw', function()
  fzf.grep_cword()
end, { desc = "Grep word under cursor" })

map('n', '<leader>fW', function()
  fzf.grep_cWORD()
end, { desc = "Grep WORD under cursor" })

map('n', '<leader>gl', function()
  fzf.git_bcommits()
end, { desc = "Git commits (file)" })

map('n', '<leader>gL', function()
  fzf.git_commits()
end, { desc = "Git commits (project)" })

map('n', '<leader>fm', function()
  fzf.keymaps()
end, { desc = "Find keymaps" })
