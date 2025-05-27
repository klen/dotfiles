local common = require "lsp.common"

return vim.tbl_deep_extend("force", common, {
  filetypes = { "p8", "lua" },
  capabilities = {
    documentFormattingProvider = false,
  },
})
