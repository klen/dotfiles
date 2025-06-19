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
      "sanghen/blink.cmp",
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

  -- Copilot
  require "plugins/lsp/copilot-vim",
  require "plugins/lsp/copilotchat-nvim",
  -- require "plugins/lsp/copilot",

  -- require "plugins/lsp/llm",
}
