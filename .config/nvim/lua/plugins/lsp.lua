return {

  -- Support LSP
  "neovim/nvim-lspconfig",

  -- Install LSP servers
  {
    "williamboman/nvim-lsp-installer",
    requires = { "neovim/nvim-lspconfig" },
    config = function()
      require "configs/lsp"
    end,
  },

  -- Support non-lsp formatters/linters/etc
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = require "configs/lsp/null-ls",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },

  -- Refactoing (only nvim >= 0.6.0)
  -- {
  --   "ThePrimeagen/refactoring.nvim",
  --   requires = {
  --     {"nvim-lua/plenary.nvim"},
  --     {"nvim-treesitter/nvim-treesitter"}
  --   }
  -- },

  -- Support LSP colors
  "folke/lsp-colors.nvim",

  -- Configure diagnosticls
  {
    "creativenull/diagnosticls-configs-nvim",
    requires = { "neovim/nvim-lspconfig" },
  },

  -- Configure semneko lua
  {
    "folke/lua-dev.nvim",
    module = "lua-dev",
  },

  -- Better UI
  {
    "rinx/lspsaga.nvim",
    config = require "configs.lspsaga",
  },

  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },

  -- {
  --   'RishabhRD/nvim-lsputils',
  --   requires = {'RishabhRD/popfix'}
  -- },
  -- {
  --   "folke/trouble.nvim",
  --   config = require('configs.trouble'),
  -- },
}