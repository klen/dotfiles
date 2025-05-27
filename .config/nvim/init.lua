-- Speed up Neovim
if vim.loader then
  vim.loader.enable()
end

-- Some options
vim.g.mapleader = ","
vim.g.maplocalleader = " "
vim.g.editorconfig = false

-- Setup plugins
require "plugins"

-- Setup LSP
require "lsp"

-- Mapping
require "keymaps"

-- User config
local config = require "config"

-- Colorscheme
pcall(vim.cmd, "colorscheme " .. config.colorscheme) ---@diagnostic disable-line
