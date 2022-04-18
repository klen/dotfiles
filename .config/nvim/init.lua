-- Init Neovim
vim.g.start_time = vim.fn.reltime()

-- Speed up Neovim
pcall(require, "impatient")

-- Setup globals
require "tools/globals"

-- Plugins
require "plugin"

-- Mapping
require "keymaps"

-- User config
local config = require "config"

-- Colorscheme
local ok, _ = pcall(vim.cmd, "colorscheme " .. config.colorscheme)
if not ok then
  cmd "colorscheme default"
end
