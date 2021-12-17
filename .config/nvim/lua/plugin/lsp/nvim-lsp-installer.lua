return {
  "williamboman/nvim-lsp-installer",
  requires = { "neovim/nvim-lspconfig" },
  config = function()
    require("nvim-lsp-installer").on_server_ready(function(server)
      local config = {
        on_attach = require "plugin/lsp/on_attach",
        handlers = require "plugin/lsp/handlers",
        capabilities = require "plugin/lsp/capabilities",
        flags = { debounce_text_changes = 150 },
      }
      local ok, server_init = pcall(require, "plugin.lsp.servers." .. server.name)
      if ok then
        config = server_init(config)
      end
      server:setup(config)
      vim.cmd [[ do User LspAttachBuffers ]]
    end)
  end,
}