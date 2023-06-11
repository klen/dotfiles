local common = require "lsp.common"
local severity = vim.diagnostic.severity

return vim.tbl_deep_extend("force", common, {
  capabilities = {
    documentFormattingProvider = false,
    documentRangeFormattingProvider = false,
  },
  diagnostic = {
    disable = { 8006, 8008, 8010, 8011, 7006 },
    severity = { min = severity.INFO },
  },
})
