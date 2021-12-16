local utils = require "plugin/lsp/utils"
local handlers = {}

handlers["workspace/symbol"] = utils.processSymbols
handlers["textDocument/documentSymbol"] = utils.processSymbols
handlers["callHierarchy/incomingCalls"] = utils.processCalls
handlers["callHierarchy/outgoingCalls"] = utils.processCalls
handlers["textDocument/definition"] = utils.gotoDefinition
handlers["textDocument/references"] = utils.processLocations
handlers["textDocument/implementation"] = utils.processLocations
handlers["textDocument/declaration"] = utils.processLocations
handlers["textDocument/typeDefinition"] = utils.processLocations
handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "rounded" })
handlers["textDocument/signatureHelp"] = lsp.with(
  lsp.handlers.signature_help,
  { border = "rounded" }
)

-- handlers["textDocument/codeAction"] = utils.processActions
-- handlers["textDocument/rename"] = utils.rename
-- handlers["textDocument/publishDiagnostics"] = lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   signs = true, -- Place Signs
--   underline = false, -- Underline errors
--   virtual_text = true, -- Enable virtual text
--   update_in_insert = false, -- update diagnostics insert mode
-- })

return handlers
