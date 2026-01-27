local lsp = vim.lsp
local severity = vim.diagnostic.severity

return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      ["*"] = {
        handlers = {
          ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
            local client = lsp.get_client_by_id(ctx.client_id)
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
      },
      pyright = {
        diagnostic = {
          severity = { min = severity.INFO },
        },
      },
    },
  },
}
