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

-- Configure lua_ls for Neovim Lua development
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      completion = {
        callSnippet = "Disable",
        keywordSnippet = "Disable",
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
})

-- LSP
vim.lsp.enable(servers_enabled)
