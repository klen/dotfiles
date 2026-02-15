return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff" },
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
    {
      "<leader>gf",
      "<cmd>Git log --follow -- %<cr>",
      desc = "Git File History",
    },
  },
}
