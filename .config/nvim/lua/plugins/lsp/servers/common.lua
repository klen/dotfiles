local utils = require("utils")

return {
  keys = {
    {
      "gd",
      function()
        vim.lsp.buf.definition({ on_list = utils.lsp_on_list })
      end,
      desc = "Go to definition",
    },
    {
      "gy",
      function()
        vim.lsp.buf.type_definition({ on_list = utils.lsp_on_list })
      end,
      desc = "Go to type definition",
    },
    {
      "gr",
      vim.lsp.buf.references,
      desc = "Go to references",
    },
  },
  handlers = {
    ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local diagnostic_config = client and client.config and client.config.diagnostic

      -- Filter diagnostics based on severity level if configured
      local severity_min = diagnostic_config and diagnostic_config.severity and diagnostic_config.severity.min
      if severity_min then
        result.diagnostics = vim.tbl_filter(function(message)
          return message.severity <= severity_min
        end, result.diagnostics)
      end

      local disabled = diagnostic_config and diagnostic_config.disabled
      if disabled then
        result.diagnostics = vim.tbl_filter(function(message)
          return not vim.tbl_contains(disabled, message.code)
        end, result.diagnostics)
      end

      vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    end,
  },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false,
        },
      },
    },
  },
  diagnostic = {
    severity = { min = vim.diagnostic.severity.INFO },
  },
}
