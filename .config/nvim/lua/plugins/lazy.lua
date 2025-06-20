-- Bootstrap lazy.nvim plugin manager

-- Define the installation path for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is already installed.
-- `vim.uv.fs_stat(path)` checks if a path exists and returns its stats or nil.
if not vim.uv.fs_stat(lazypath) then
  -- If not installed, clone the repository
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  -- Check if the git clone command failed
  if vim.v.shell_error ~= 0 then
    -- Display an error message if cloning fails
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" }, -- Display the output from the git command
      { "\nPress any key to exit..." },
    }, true, {})             -- 'true' for a more permanent message, '{}' for no options
    vim.fn.getchar()         -- Wait for user input
    os.exit(1)               -- Exit Neovim
  end
end

-- Prepend lazy.nvim to the runtimepath so Neovim can find it
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim and the custom configuration module
local lazy = require("lazy")  -- The lazy.nvim module itself
local cfg = require("config") -- Your custom config module, assumed to have a 'keymaps' table

-- Setup keybindings for lazy.nvim operations, adding them to your custom 'cfg.keymaps' table.
-- These mappings allow easy interaction with lazy.nvim directly from Neovim.

-- <leader>pu: Update all installed plugins
table.insert(cfg.keymaps, {
  "<leader>pu",
  function()
    lazy.update()
  end,
  desc = "Update your plugins",
})

-- <leader>pp: Show the plugins status dashboard
table.insert(cfg.keymaps, {
  "<leader>pp",
  function()
    lazy.home() -- Opens the lazy.nvim dashboard/home page
  end,
  desc = "Plugins Status",
})

-- <leader>pc: Clean up unused/orphaned plugins
table.insert(cfg.keymaps, {
  "<leader>pc",
  function()
    lazy.clean()
  end,
  desc = "Clean unused plugins",
})

-- <leader>pb: Run the build step for plugins (e.g., compile treesitter parsers)
table.insert(cfg.keymaps, {
  "<leader>pb",
  function()
    lazy.build()
  end,
  desc = "Build your plugins",
})

-- Return the lazy.nvim module.
-- This module is likely required by other parts of your configuration
-- to define plugin specifications (e.g., in `plugins/init.lua`).
return lazy
