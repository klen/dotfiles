return {

  -- Support LSP
  require "plugins/lsp/nvim-lspconfig",

  -- Install LSP servers
  require "plugins/lsp/nvim-lsp-installer",

  -- Support non-lsp formatters/linters/etc
  require "plugins/lsp/null-ls",

  -- -- Support LSP status for statusline
  -- require "plugins/lsp/lsp-status",

  -- Support LSP colors
  "folke/lsp-colors.nvim",

  -- -- Signature helper
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   config = function()
  --     require("lsp_signature").setup {}
  --   end,
  -- },

  -- Configure diagnosticls
  {
    "creativenull/diagnosticls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },

  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },
}
