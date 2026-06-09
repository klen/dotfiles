vim.pack.add({

  -- LSP configure
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

local lsp_config = require "lsp.config"
local servers_enabled = lsp_config.enabled

-- Disable snippet support for all LSP servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false
vim.lsp.config("*", {
  capabilities = capabilities,
})

for _, server in ipairs(servers_enabled) do
  local ok, custom_config = pcall(require, "lsp.servers." .. server)
  if ok and custom_config then
    vim.lsp.config(server, custom_config)
  end
end


-- LSP
vim.lsp.enable(servers_enabled)
