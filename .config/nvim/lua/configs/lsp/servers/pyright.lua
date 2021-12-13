return function(defaults)
  return vim.tbl_extend("force", defaults, {

    -- Pyright settings
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
          diagnosticMode = "openFilesOnly",
          diagnosticSeverityOverrides = {
            reportSelfClsParameterName = "none",
          },
        },
      },
    },

    -- Disable hints
    handlers = vim.tbl_extend("force", defaults.handlers, {
      ["textDocument/publishDiagnostics"] = function(err, result, ctx, _)
        result.diagnostics = vim.tbl_filter(function(message)
          return message.severity < 4
        end, result.diagnostics)

        -- TODO: support nvim 0.6.0
        lsp.diagnostic.on_publish_diagnostics(err, result, ctx, {
          signs = true, -- Place Signs
          underline = false, -- Underline errors
          virtual_text = true, -- Enable virtual text
          update_in_insert = false, -- update diagnostics insert mode
        })
      end,
    }),

    -- Disable formatting
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      defaults.on_attach(client)
    end,

    -- Auto load VIRTUALENV
    before_init = function(_, config)
      if vim.env.VIRTUAL_ENV then
        config.settings.python.pythonPath = vim.env.VIRTUAL_ENV .. "/bin/python"
      end
    end,
  })
end
