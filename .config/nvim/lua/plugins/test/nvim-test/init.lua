return require("utils").local_plugin("~/projects/nvim/test", "klen/nvim-test", {
  keys = {
    { "<leader>t", "", desc = "+test" },
    { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Run the nearest test" },
    { "<leader>tf", "<cmd>TestFile<cr>", desc = "Run all tests in current file" },
    { "<leader>tl", "<cmd>TestLast<cr>", desc = "Run the last executed test" },
    { "<leader>tt", "<cmd>TestSuite<cr>", desc = "Run the entire test suite" },
    { "<leader>tv", "<cmd>TestVisit<cr>", desc = "Visit the last test file" },
    { "<leader>te", "<cmd>TestEdit<cr>", desc = "Edit tests (if supported by runner)" },
  },
  opts = {
    termOpts = {
      width = math.max(math.ceil(vim.o.columns * 0.35), 40), -- Terminal width: 35% of columns or min 40
    },
  },
})
