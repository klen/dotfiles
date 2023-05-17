local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- Install and setup lazy
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
local lazy = require "lazy"
lazy.setup "plugins"

-- Setup mappings
local cfg = require "config"
cfg.keymaps["<leader>pu"] = { lazy.update, "Update your plugins" }
cfg.keymaps["<leader>pp"] = { lazy.home, "Plugins Status" }
cfg.keymaps["<leader>pc"] = { lazy.clean, "Clean unused plugins" }
cfg.keymaps["<leader>pb"] = { lazy.build, "Build your plugins" }
