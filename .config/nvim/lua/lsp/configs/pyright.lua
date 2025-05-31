local common = require "lsp.common"
local severity = vim.diagnostic.severity

return vim.tbl_deep_extend("force", common, {
  -- LSP Settings
  settings = {
    python = {
      analysis = {
        -- typeCheckingMode = "off",
        diagnosticMode = "openFilesOnly",
        diagnosticSeverityOverrides = {
          reportSelfClsParameterName = "none",
        },
      },
    },
  },

  format = false, -- Disable formatting

  -- Setup Diagnostics
  diagnostic = {
    severity = { min = severity.INFO },
  },

  -- Auto load VIRTUALENV
  -- before_init = function(_, config)
  --   if vim.env.VIRTUAL_ENV then
  --     config.settings.python.pythonPath = vim.env.VIRTUAL_ENV .. "/bin/python"
  --   end
  -- end,
})
