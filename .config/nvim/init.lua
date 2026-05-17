-- Speed up Neovim
vim.loader.enable()

-- Set the leader keys before loading plugins and configs
vim.g.mapleader = " "      -- Set the global leader key
vim.g.maplocalleader = " " -- Set the buffer-local leader key

require('config')
require('plugins')
require('lsp')
require('config/ui')
