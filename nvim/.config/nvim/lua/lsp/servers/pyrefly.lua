local utils = require('lsp.utils')

return {
  handlers = {
    ["textDocument/publishDiagnostics"] = utils.filter_diagnostics(vim.diagnostic.severity.INFO),
  },
}
