local common = require "lsp.common"

return vim.tbl_deep_extend("force", common, {
  autostart = false,
  filetypes = { "lua" },
})
