local lsp_installer = require "nvim-lsp-installer"

vim.diagnostic.config {
  underline = false,
}

-- replace the default lsp diagnostic symbols
fn.sign_define("DiagnosticSignError", { text = "EE", texthl = "DiagnosticError" })
fn.sign_define("DiagnosticSignWarn", { text = "WW", texthl = "DiagnosticWarn" })
fn.sign_define("DiagnosticSignInfo", { text = "II", texthl = "DiagnosticInfo" })
fn.sign_define("DiagnosticSignHint", { text = "HH", texthl = "DiagnosticHint" })

-- Auto populate quickfix
cmd [[
  augroup lsp
    autocmd!
    au User DiagnosticChanged lua require('utils/lsp').diagnostics('document')
  augroup END
]]

local disabled_servers = {}

-- Setup servers
lsp_installer.on_server_ready(function(server)
  if table.contains(disabled_servers, server.name) then
    return nil
  end
  local config = {
    on_attach = require "setup/lsp/on_attach",
    handlers = require "setup/lsp/handlers",
    capabilities = require "setup/lsp/capabilities",
    flags = { debounce_text_changes = 150 },
  }
  local ok, configure = pcall(require, "setup.lsp.servers." .. server.name)
  if ok then
    config = configure(config)
  end
  server:setup(config)

  cmd [[ do User LspAttachBuffers ]]
end)
