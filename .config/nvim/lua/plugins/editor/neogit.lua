-- A git interface for Neovim, inspired by Magit.
-- https://github.com/NeogitOrg/neogit
return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
