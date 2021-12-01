local lsp_installer = require("nvim-lsp-installer")

-- replace the default lsp diagnostic symbols
fn.sign_define("LspDiagnosticsSignError", { text = 'EE', numhl = "LspDiagnosticsDefaultError" })
fn.sign_define("LspDiagnosticsSignWarning", { text = 'WW', numhl = "LspDiagnosticsDefaultWarning" })
fn.sign_define("LspDiagnosticsSignInformation", { text = 'II', numhl = "LspDiagnosticsDefaultInformation" })
fn.sign_define("LspDiagnosticsSignHint", { text = 'HH', numhl = "LspDiagnosticsDefaultHint" })

-- Auto populate quickfix
cmd [[
  augroup lsp
    autocmd!
    au User LspDiagnosticsChanged lua require('utils/lsp').diagnostics('document')
  augroup END
]]

local disabled_servers = {}

-- Setup servers
lsp_installer.on_server_ready(function(server)
  if table.contains(disabled_servers, server.name) then
    return nil
  end
  local config = {
    on_attach = require'configs/lsp/on_attach',
    handlers = require'configs/lsp/handlers',
    capabilities = require'configs/lsp/capabilities',
    flags = {debounce_text_changes = 150}
  }
  local ok, configure = pcall(require, 'configs.lsp.servers.' .. server.name)
  if ok then
    config = configure(config)
  end
  server:setup(config)

  cmd [[ do User LspAttachBuffers ]]

end)
