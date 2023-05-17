-- Search Dash.app from your Neovim fuzzy finder
-- https://github.com/mrjones2014/dash.nvim
return {
  "mrjones2014/dash.nvim",
  run = "make install",
  config = function()
    local cfg = require "config"
    cfg.keymaps["<leader>fd"] = { "<cmd>Dash<cr>", "Search in dash" }
    cfg.keymaps["<leader>fD"] = { "<cmd>DashWord<cr>", "Search current word in dash" }
  end,
}
