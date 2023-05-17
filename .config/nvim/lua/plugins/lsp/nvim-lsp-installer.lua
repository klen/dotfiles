return {
  "williamboman/nvim-lsp-installer",
  dependencies = "neovim/nvim-lspconfig",
  config = function()
    require("nvim-lsp-installer").on_server_ready(function(server)
      -- Basic params
      local generate_handlers = require "plugins.lsp.handlers"
      local params = {
        on_attach = require "plugins.lsp.on_attach",
        handlers = generate_handlers(),
        capabilities = require "plugins.lsp.capabilities",
        flags = { debounce_text_changes = 150 },
      }

      local ok, server_init = pcall(require, "plugins.lsp.servers." .. server.name)
      if ok then
        params = server_init(params)
      end
      server:setup(params)
      vim.cmd "do User LspAttachBuffers"
    end)
  end,
}
