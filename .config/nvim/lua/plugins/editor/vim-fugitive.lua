return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git Diff" },
    {
      "<leader>gs",
      function()
        vim.cmd("above Git")
        vim.cmd("resize 15")
      end,
      desc = "Git Status",
    },
    { "<leader>gl", "<cmd>Gclog -- %<cr>", desc = "Git Buffer History" },
    { "<leader>gL", "<cmd>Gclog<cr>", desc = "Git History" },
    {
      "<leader>gf",
      "<cmd>Git log --follow -- %<cr>",
      desc = "Git File History",
    },
  },
}
