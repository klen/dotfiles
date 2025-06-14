require "tools/table"

local utils = require "lsp.utils"
local lsp = vim.lsp

return {
  ["window/logMessage"] = utils.logMessage,
  ["window/showMessage"] = utils.showMessage,
  ["workspace/symbol"] = utils.processSymbols,
  ["textDocument/documentSymbol"] = utils.processSymbols,
  ["callHierarchy/incomingCalls"] = utils.processCalls,
  ["callHierarchy/outgoingCalls"] = utils.processCalls,
  ["textDocument/definition"] = utils.gotoDefinition,
  ["textDocument/references"] = utils.processLocations,
  ["textDocument/implementation"] = utils.processLocations,
  ["textDocument/declaration"] = utils.processLocations,
  ["textDocument/typeDefinition"] = utils.gotoDefinition,
  ["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "single" }),
  ["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "single" }),

  ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
    local client = lsp.get_client_by_id(ctx.client_id)
    if not client or not client.config then
      return
    end
    local ds_config = client.config.diagnostic
    if ds_config then
      -- Filter by severity
      if ds_config and ds_config.severity and ds_config.severity.min then
        result.diagnostics = vim.tbl_filter(function(message)
          return message.severity <= ds_config.severity.min
        end, result.diagnostics)
      end
      -- Filter by codes
      if ds_config.disable then
        result.diagnostics = vim.tbl_filter(function(message)
          return not table.contains(ds_config.disable, message.code)
        end, result.diagnostics)
      end
    end
    lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
  end,
}

-- handlers["textDocument/codeAction"] = utils.processActions
-- handlers["textDocument/rename"] = utils.rename
