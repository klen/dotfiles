-- Speed up Neovim
pcall(require, "impatient")

-- Setup globals
require "utils/globals"

-- Vim options
vim.cmd "source ~/.config/nvim/opts.vim"

-- Auto commands
vim.cmd "source ~/.config/nvim/auto.vim"

-- Mapping
require "maps"

-- Plugins
require "plugins"

-- Colorscheme
-- cmd "colorscheme covid19"
cmd "colorscheme vscode"

-- Must be written at the last.  see :help 'secure'.
vim.opt.secure = true
