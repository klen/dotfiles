local utils = require('lsp.utils')

return {
  handlers = {
    -- Drop hint-level diagnostics (e.g. "File is a CommonJS module").
    ["textDocument/publishDiagnostics"] = utils.filter_diagnostics(vim.diagnostic.severity.INFO),
  },
}
