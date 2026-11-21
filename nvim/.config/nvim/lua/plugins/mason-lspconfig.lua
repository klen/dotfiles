-- Bridge between Mason packages and `vim.lsp.enable()` in nvim-lspconfig.lua
vim.pack.add({ { src = 'https://github.com/mason-org/mason-lspconfig.nvim' } })

require('mason-lspconfig').setup {
  automatic_enable = false, -- we call vim.lsp.enable() ourselves
  ensure_installed = require('lsp.config').ensure_installed,
}
