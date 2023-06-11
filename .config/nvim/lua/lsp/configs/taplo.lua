local common = require "lsp.common"

return vim.tbl_deep_extend("force", common, {
  settings = {
    formatter = {
      alignEntries = false,
      columnWidth = 100,
    },
  },
})
