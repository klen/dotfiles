-- Portable package manager for Neovim
vim.pack.add({

  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})

local lsp = require "lsp.config"
require("mason").setup()
require("mason-lspconfig").setup {
  automatic_enable = false,
  automatic_installation = true,
  ensure_installed = lsp.ensure_installed,
}
