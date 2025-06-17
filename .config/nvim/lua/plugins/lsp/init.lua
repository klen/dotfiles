return {

  -- Install and tune LSP servers
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = require "lsp.servers",
      automatic_installation = true,
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  -- Configure diagnosticls
  {
    "creativenull/diagnosticls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },

  -- Support non-lsp formatters/linters/etc
  require "plugins/lsp/none-ls",

  -- -- Support LSP status for statusline
  -- require "plugins/lsp/lsp-status",

  -- Completion
  require "plugins/lsp/nvim-cmp",

  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },

  -- require "plugins/lsp/llm",
}
