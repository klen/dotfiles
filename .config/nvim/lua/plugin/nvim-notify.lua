-- A fancy, configurable, notification manager for NeoVim
-- https://github.com/rcarriga/nvim-notify
return {
  "rcarriga/nvim-notify",
  config = function()
    vim.notify = require "notify"
    require("notify").setup { timeout = 2000, stages = "static" }
  end,
}
