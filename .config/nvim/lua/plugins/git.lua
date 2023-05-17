-- Git support

return {
  "lewis6991/gitsigns.nvim",
  {
    "tpope/vim-fugitive",
    keys = {
      "<leader>ga",
      "<leader>gb",
      "<leader>gd",
      "<leader>gs",
      "<leader>gr",
      "<leader>gp",
      "<leader>gc",
    },
    dependencies = { "folke/which-key.nvim" },
    config = function()
      local wk = require "which-key"
      wk.register {
        ["<leader>ga"] = { "<cmd>Gwrite<cr>", "Git add" },
        ["<leader>gb"] = { "<cmd>Git blame<cr>", "Git blame" },
        ["<leader>gd"] = { "<cmd>Gdiffsplit<cr>", "Git diff" },
        ["<leader>gs"] = { "<cmd>abo Git<cr>", "Git status" },
        ["<leader>gr"] = { "<cmd>Gdelete<cr>", "Git remove" },
        ["<leader>gp"] = { "<cmd>Git push<cr>", "Git push all" },
        ["<leader>gc"] = { "<cmd>Git commit %<cr>", "Git commit" },
      }
    end,
  },
}
