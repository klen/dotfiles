-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.ai_cmp = false

-- Line Numbers
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = false
vim.opt.signcolumn = "number"
vim.opt.statuscolumn = "" -- Reset lazyvim statuscolumn

-- Bracket/Pair Matching
vim.opt.showmatch = true -- Show matching brackets
vim.opt.matchpairs:append("<:>") -- Add <> to the list of matchable pairs

-- Misc Editing
vim.opt.virtualedit = "all" -- Allow the cursor to move into "virtual" space

-- Restore VIM defaults
vim.opt.fillchars = {
  foldopen = "-",
  foldclose = "+",
  fold = "·",
  foldsep = "|",
  diff = "-",
  eob = "~",
}

-- vim.g.lazyvim_python_lsp = "ty"
vim.g.lazyvim_python_lsp = "pyrefly"
