return function()
  local u = require "utils"

  require("trouble").setup {
    icons = false,
    mode = "lsp_document_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
    auto_open = false,
    auto_close = false,
    use_lsp_diagnostic_signs = true,
  }

  u.nmap("<leader>ll", ":TroubleToggle<CR>")
end
