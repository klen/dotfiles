-- Speed up Neovim
vim.loader.enable()

require "config/opts"
require "config/auto"
require "config/keymaps"

-- Setup plugins
require "config/lazy"

-- Setup LSP
require "lsp"

-- User config
local config = require "config"

-- Colorscheme
pcall(vim.cmd, "colorscheme " .. config.colorscheme) ---@diagnostic disable-line
