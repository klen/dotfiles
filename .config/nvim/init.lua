-- Speed up Neovim
if vim.loader then
  vim.loader.enable()
end

-- Some options
vim.g.mapleader = ","      -- Set leader keys
vim.g.maplocalleader = " " -- Set leader keys
vim.g.editorconfig = false -- Disable editorconfig plugin
vim.g.showmode = false     -- Disable showmode, use statusline instead

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
