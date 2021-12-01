local utils = require('utils/lsp')
local handlers = {}

handlers['workspace/symbol'] = utils.processSymbols
handlers['callHierarchy/incomingCalls'] = utils.processCalls
handlers['callHierarchy/outgoingCalls'] = utils.processCalls
-- handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
handlers['textDocument/codeAction'] = utils.processActions
handlers["textDocument/references"] = utils.processLocations
handlers["textDocument/implementation"] = utils.processLocations
handlers["textDocument/declaration"] = utils.processLocations
handlers["textDocument/typeDefinition"] = utils.processLocations
handlers['textDocument/documentSymbol'] = utils.processSymbols
-- handlers['textDocument/rename'] = require('lspsaga.rename').rename
handlers['textDocument/hover'] = require('lspsaga.hover').handler
handlers['textDocument/signatureHelp'] = require('lspsaga.signaturehelp').signature_help
handlers["textDocument/publishDiagnostics"] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
    signs = true,             -- Place Signs
    underline = false,        -- Underline errors
    virtual_text = true,      -- Enable virtual text
    update_in_insert = false, -- update diagnostics insert mode
  }
)

return handlers
