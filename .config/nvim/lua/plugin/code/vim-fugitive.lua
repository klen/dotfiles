-- A Git wrapper so awesome, it should be illegal
-- https://github.com/tpope/vim-fugitive
return {
  "tpope/vim-fugitive",
  setup = function()
    local cfg = require "config"
    cfg.keymaps["<leader>ga"] = { "<cmd>Gwrite<cr>", "Git add" }
    cfg.keymaps["<leader>gb"] = { "<cmd>Git blame<cr>", "Git blame" }
    cfg.keymaps["<leader>gd"] = { "<cmd>Gdiffsplit<cr>", "Git diff" }
    cfg.keymaps["<leader>gs"] = { "<cmd>abo Git<cr>", "Git status" }
    cfg.keymaps["<leader>gr"] = { "<cmd>Gdelete<cr>", "Git remove" }
    cfg.keymaps["<leader>gp"] = { "<cmd>Git push<cr>", "Git push all" }
    cfg.keymaps["<leader>gc"] = { "<cmd>Git commit %<cr>", "Git commit" }
  end,
}
