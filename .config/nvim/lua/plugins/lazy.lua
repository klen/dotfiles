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

-- Setup mappings
local lazy = require "lazy"
local cfg = require "config"
table.insert(cfg.keymaps, {
  "<leader>pu",
  function()
    lazy.update()
  end,
  desc = "Update your plugins",
})
table.insert(cfg.keymaps, {
  "<leader>pp",
  function()
    lazy.home()
  end,
  desc = "Plugins Status",
})
table.insert(cfg.keymaps, {
  "<leader>pc",
  function()
    lazy.clean()
  end,
  desc = "Clean unused plugins",
})
table.insert(cfg.keymaps, {
  "<leader>pb",
  function()
    lazy.build()
  end,
  desc = "Build your plugins",
})

return lazy
