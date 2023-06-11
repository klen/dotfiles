local util = require "lspconfig/util"
local common = require "lsp.common"

return vim.tbl_deep_extend("force", common, {
  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
})
