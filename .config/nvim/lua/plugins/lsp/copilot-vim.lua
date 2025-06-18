return {
  "github/copilot.vim",
  build = ":Copilot auth",
  config = function()
    vim.keymap.set("i", "<M-l>", "<cmd>:Copilot<cr>")
  end,
}
