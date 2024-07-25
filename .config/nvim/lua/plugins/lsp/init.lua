return {

  -- Install and tune LSP servers
  {
    "williamboman/mason.nvim",
    lazy = true,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup { ensure_installed = require "lsp.servers" }
    end,
  },
  require "plugins/lsp/nvim-lspconfig",

  -- Support non-lsp formatters/linters/etc
  -- require "plugins/lsp/null-ls",
  require "plugins/lsp/none-ls",

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
