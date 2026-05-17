local utils = require("utils")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }


-- Restart NVIM
map("n", "<leader>dr", "<cmd>restart<cr>", { desc = "Restart NVIM" })

-- Clear search, diff update and redraw
map("n", "<C-c>", function()
  vim.cmd("nohlsearch")
  vim.cmd("diffupdate")
  vim.api.nvim_command("redraw")
  vim.api.nvim_buf_clear_namespace(0, 0, 0, -1)
  vim.snippet.stop()
end, { desc = "Redraw / Clear hlsearch / Diff Update" })

-- Save the current file.
map("n", "<CR>", function()
  local buftype = vim.bo.buftype
  if buftype ~= "" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
    return
  end
  vim.cmd("write")
end, { desc = "Save File" })

-- Fast save (assuming `tools.fast_save` handles this)
map("n", "<S-CR>", utils.fast_save, { desc = "Save File (no prompts)" })

-- Manage windows
map("n", "<C-w>cc", "<cmd>close<cr>", { desc = "Close current window" })
map("n", "<C-w>ck", "<cmd>wincmd k<cr><cmd>close<cr>", { desc = "Close window up" })
map("n", "<C-w>cj", "<cmd>wincmd j<cr><cmd>close<cr>", { desc = "Close window down" })
map("n", "<C-w>ch", "<cmd>wincmd h<cr><cmd>close<cr>", { desc = "Close window left" })
map("n", "<C-w>cl", "<cmd>wincmd l<cr><cmd>close<cr>", { desc = "Close window right" })
map("n", "<C-s>", "<C-w>s", { desc = "Split window horizontally" })

-- When using '*', only highlight occurrences, do not jump to the next match.
map("n", "*", "*N", { desc = "Highlight all occurrences of word under cursor" })

-- Delete character under cursor without copying it to register.
-- This prevents overwriting your paste buffer with single character deletes.
map("n", "x", '"_x',
  { desc = "Delete character under cursor without copying it", noremap = true, silent = true })

-- Keep search results centered on the screen.
-- 'zz' centers the screen, 'zv' makes sure the cursor line is visible.
map("n", "n", "nzzzv", { desc = "Next search match (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search match (centered)" })

map("n", "<leader>qq", '<cmd>qa<cr>', { desc = "Quit Nvim" })

-- Map 'k' and 'j' to 'gk' and 'gj' respectively.
-- This makes vertical movement consistent across wrapped and unwrapped lines.
map({ "n", "v" }, "j", function() return vim.v.count == 0 and "gj" or "j" end, { expr = true })
map({ "n", "v" }, "k", function() return vim.v.count == 0 and "gk" or "k" end, { expr = true })

-- C+Space to trigger completion menu
map("i", "<C-Space>", function()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true),
    "n",
    true
  )
end, { expr = true, desc = "Trigger completion menu" })

-- Terminal mode
map("t", "<Esc>", [[<C-\\><C-n>]], { desc = "Exit terminal mode" })
map("t", "<C-[>", [[<C-\\><C-n>]], { desc = "Exit terminal mode" })
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]])

-- remap "p" in visual mode to delete the highlighted text without overwriting your yanked/copied text, and then paste the content from the unnamed register.
map("v", "p", '"_dP', opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Reload the current buffer from disk.
map('n', '<leader>b', '', { desc = "+buffers" })
map("n", "<leader>br", function()
  vim.cmd("edit!")
end, { desc = "Reload Buffer from Disk" })

-- Diff shortcuts
map('n', '<leader>d', '', { desc = '+debug/diff' })
map('n', '<leader>dt', ':diffthis<CR>', { desc = 'Diff this' })
map('n', '<leader>dp', ':diffput<CR>', { desc = 'Diff put' })
map('n', '<leader>dg', ':diffget<CR>', { desc = 'Diff get' })
