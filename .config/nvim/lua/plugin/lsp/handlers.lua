local utils = require "plugin/lsp/utils"
local cfg = require "config"

return function()
  return {
    ["workspace/symbol"] = utils.processSymbols,
    ["textDocument/documentSymbol"] = utils.processSymbols,
    ["callHierarchy/incomingCalls"] = utils.processCalls,
    ["callHierarchy/outgoingCalls"] = utils.processCalls,
    ["textDocument/definition"] = utils.gotoDefinition,
    ["textDocument/references"] = utils.processLocations,
    ["textDocument/implementation"] = utils.processLocations,
    ["textDocument/declaration"] = utils.processLocations,
    ["textDocument/typeDefinition"] = utils.processLocations,
    ["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "single" }),
    ["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "single" }),
    ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      -- Filter diagnostic messages by severity
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local client_cfg = cfg.lsp.servers[client.name]
      if client_cfg and client_cfg.diagnostic and client_cfg.diagnostic.severity then
        result.diagnostics = vim.tbl_filter(function(message)
          return message.severity <= client_cfg.diagnostic.severity.min
        end, result.diagnostics)
      end
      vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
    end,
  }

  -- handlers["textDocument/codeAction"] = utils.processActions
  -- handlers["textDocument/rename"] = utils.rename
end
