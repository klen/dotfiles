local tools = require "tools"

return {
  tools.local_plugin("~/projects/nvim/test", "klen/nvim-test"),
  config = function()
    require("nvim-test").setup()
  end,
  setup = function()
    local cfg = require "config"
    cfg.keymaps["<leader>tn"] = { "<cmd>TestNearest<cr>", "Run the nearest test" }
    cfg.keymaps["<leader>tf"] = { "<cmd>TestFile<cr>", "Run the file" }
    cfg.keymaps["<leader>tl"] = { "<cmd>TestLast<cr>", "Run the last test" }
    cfg.keymaps["<leader>tt"] = { "<cmd>TestSuite<cr>", "Run all tests" }
    cfg.keymaps["<leader>tv"] = { "<cmd>TestVisit<cr>", "Visit the last test" }
  end,
}
