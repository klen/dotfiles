local common = require "lsp.common"

return vim.tbl_deep_extend("force", common, {
  settings = {
    -- run = "onSave",
    format = { enable = true }, -- this will enable formatting
  },
})
