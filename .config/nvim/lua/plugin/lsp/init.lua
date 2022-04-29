return {

  -- Support LSP
  require "plugin/lsp/nvim-lspconfig",

  -- Install LSP servers
  require "plugin/lsp/nvim-lsp-installer",

  -- Support non-lsp formatters/linters/etc
  require "plugin/lsp/null-ls",

  -- -- Support LSP status for statusline
  -- require "plugin/lsp/lsp-status",

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
    requires = { "neovim/nvim-lspconfig" },
  },

  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },
}
