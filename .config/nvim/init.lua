-- Init Neovim
vim.g.start_time = vim.fn.reltime()

-- Speed up Neovim
vim.cmd [[
  syntax off
  filetype off
  filetype plugin indent off
]]
pcall(require, "impatient")

-- Setup globals
require "tools/globals"

-- Plugins
require "plugin"

-- Mapping
require "keymaps"

-- Colorscheme
local config = require "config"
local ok, _ = pcall(vim.cmd, "colorscheme " .. config.colorscheme)
if not ok then
  cmd "colorscheme default"
end

-- Must be written at the last.  see :help 'secure'.
vim.opt.secure = true
