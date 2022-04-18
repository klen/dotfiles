local ok, plug = pcall(require, "nvim-test")
if not ok then
  return
end

plug.setup {
  termOpts = {
    width = math.max(math.ceil(vim.o.columns * 0.35), 40),
  },
}

-- Bind keys
local cfg = require "config"
cfg.keymaps["<leader>tn"] = { "<cmd>TestNearest<cr>", "Run the nearest test" }
cfg.keymaps["<leader>tf"] = { "<cmd>TestFile<cr>", "Run the file" }
cfg.keymaps["<leader>tl"] = { "<cmd>TestLast<cr>", "Run the last test" }
cfg.keymaps["<leader>tt"] = { "<cmd>TestSuite<cr>", "Run all tests" }
cfg.keymaps["<leader>tv"] = { "<cmd>TestVisit<cr>", "Visit the last test" }
cfg.keymaps["<leader>te"] = { "<cmd>TestEdit<cr>", "Edit tests" }
