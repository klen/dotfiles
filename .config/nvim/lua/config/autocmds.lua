-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local api = vim.api
local autocmd = api.nvim_create_autocmd

-- Create an autocommand group to keep things organized and clear it on reload
api.nvim_create_augroup("config", { clear = true })

--- Terminal-Specific Autocommands ---
-- When a terminal buffer is opened, automatically enter insert mode
-- and disable line numbers for a cleaner terminal experience.
autocmd({ "TermOpen" }, {
  pattern = "*",
  command = "startinsert | setlocal nonumber norelativenumber",
  group = "config",
})
