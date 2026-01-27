-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local utils = require("utils")
local lv = require("lazyvim.util")
local map = lv.safe_keymap_set

-- Clear search, diff update and redraw
map("n", "<C-c>", function()
  vim.cmd("nohlsearch")
  vim.cmd("diffupdate")
  vim.api.nvim_command("redraw")
  vim.api.nvim_buf_clear_namespace(0, 0, 0, -1)
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

-- Diagnostics
map("n", "<C-n>", utils.diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "<C-p>", utils.diagnostic_goto(false), { desc = "Prev Diagnostic" })

-- Command mode navigation
map("c", "<C-A>", "<Home>", { desc = "Go to beginning of command line" })
map("c", "<C-E>", "<End>", { desc = "Go to end of command line" })

-- Lazy
map("", "<leader>l", "<Nop>", { desc = "lazy" })
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>lL", "<cmd>Lazy log<cr>", { desc = "Lazy Log" })
map("n", "<leader>lc", "<cmd>Lazy check<cr>", { desc = "Lazy Check" })
map("n", "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "Lazy Extras" })

-- When using '*', only highlight occurrences, do not jump to the next match.
map("n", "*", "*N", { desc = "Highlight all occurrences of word under cursor" })

-- Delete character under cursor without copying it to register.
-- This prevents overwriting your paste buffer with single character deletes.
map("n", "x", '"_x', { desc = "Delete character under cursor without copying it", noremap = true, silent = true })

-- Keep search results centered on the screen.
-- 'zz' centers the screen, 'zv' makes sure the cursor line is visible.
map("n", "n", "nzzzv", { desc = "Next search match (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search match (centered)" })
