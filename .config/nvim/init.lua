-- Speed up Neovim
vim.loader.enable()

require "config/opts"

-- Setup plugins
require "config/lazy"

-- Setup LSP
require "lsp"

-- User config
require "config/auto"
require "config/keymaps"
local config = require "config"

-- Colorscheme
pcall(vim.cmd, "colorscheme " .. config.colorscheme) ---@diagnostic disable-line
