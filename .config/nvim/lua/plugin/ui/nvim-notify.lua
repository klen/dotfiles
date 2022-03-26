-- A fancy, configurable, notification manager for NeoVim
-- https://github.com/rcarriga/nvim-notify
return {
  "rcarriga/nvim-notify",
  config = function()
    vim.notify = require "notify"
    require("notify").setup { timeout = 2000, stages = "static" }

    -- Setup telescope
    telescope = require "telescope"
    telescope.load_extension "notify"

    -- Setup keymaps
    local cfg = require "config"
    cfg.keymaps["<leader>fn"] = { "<cmd>Telescope notify<cr>", "Find notifies" }
  end,
}
