return {
  "williamboman/nvim-lsp-installer",
  requires = "neovim/nvim-lspconfig",
  config = function()
    require("nvim-lsp-installer").on_server_ready(function(server)
      -- Basic params
      local generate_handlers = require "plugin.lsp.handlers"
      local params = {
        on_attach = require "plugin.lsp.on_attach",
        handlers = generate_handlers(server.name),
        capabilities = require "plugin.lsp.capabilities",
        flags = { debounce_text_changes = 150 },
      }

      local ok, server_init = pcall(require, "plugin.lsp.servers." .. server.name)
      if ok then
        params = server_init(params)
      end
      server:setup(params)
      vim.cmd "do User LspAttachBuffers"
    end)
  end,
}
