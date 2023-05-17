-- Speed up Neovim
if vim.loader then
  vim.loader.enable()
end

-- Some options
vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- Setup plugins with https://github.com/folke/lazy.nvim
require "tools/lazy"

-- Mapping
require "keymaps"

-- User config
local config = require "config"

-- Colorscheme
pcall(vim.cmd, "colorscheme " .. config.colorscheme)
