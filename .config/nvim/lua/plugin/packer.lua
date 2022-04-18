local M = {}

-- Install packer
function M.install()
  local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

  print "Cloning packer.."
  -- remove the dir before cloning
  vim.fn.delete(packer_path, "rf")
  vim.fn.system {
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "20",
    packer_path,
  }

  vim.cmd "packadd packer.nvim"
  local present, packer = pcall(require, "packer")
  if present then
    print "Packer cloned successfully."
    return packer
  end
  error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
end

-- Setup plugins
---@param init_plugins function a startup function
function M.startup(init_plugins)
  local present, packer = pcall(require, "packer")
  if not present then
    packer = M.install()
  end
  if not packer then
    return
  end

  -- Auto update plugins
  vim.api.nvim_create_augroup("packer", { clear = true })
  vim.api.nvim_create_autocmd(
    "BufWritePost",
    { pattern = "**/nvim/lua/plugin/*.lua ", command = "source <afile> | PackerCompile", group = "packer" }
  )

  -- Start packer
  packer.startup {
    init_plugins,
    -- Configure packer
    config = {
      display = {
        open_fn = function()
          return require("packer.util").float { border = "rounded" }
        end,
        prompt_border = "rounded",
      },
      git = {
        clone_timeout = 800, -- Timeout, in seconds, for git clones
      },
      auto_clean = true,
      compile_on_sync = true,
    },
  }

  -- Bind Keys
  local cfg = require "config"
  cfg.keymaps["<leader>ps"] = { "<cmd>PackerStatus<cr>", "Plugins Status" }
  cfg.keymaps["<leader>pu"] = { "<cmd>PackerSync<cr>", "Update your plugins" }
  cfg.keymaps["<leader>pc"] = { "<cmd>PackerClean<cr>", "Clean unused plugins" }
  cfg.keymaps["<leader>pC"] = { "<cmd>PackerCompile<cr>", "Compile your plugins changes" }
  cfg.keymaps["<leader>pi"] = { "<cmd>PackerInstall<cr>", "Install missing plugins" }

  if M.first_install then
    packer.sync()
  end
end

return M
