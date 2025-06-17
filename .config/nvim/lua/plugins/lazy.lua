-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
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
