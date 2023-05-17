return {
  "nvim-lua/lsp-status.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    local lsp_status = require "lsp-status"
    lsp_status.register_progress()
  end,
}
