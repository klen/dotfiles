-- Init Neovim
vim.g.start_time = vim.fn.reltime()

-- Speed up Neovim
if vim.loader then
  vim.loader.enable()
end

vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- Plugins
require "plugin"

-- Mapping
require "keymaps"

-- User config
local config = require "config"

-- Colorscheme
pcall(vim.cmd, "colorscheme " .. config.colorscheme)
