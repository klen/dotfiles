M = {}

M.filter_diagnostics = function(min_severity)
  local orig_diagnostics_publish = vim.lsp.handlers["textDocument/publishDiagnostics"]

  return function(err, result, ctx, config)
    if result and result.diagnostics then
      result.diagnostics = vim.tbl_filter(function(diagnostic)
        return diagnostic.severity and diagnostic.severity <= min_severity
      end, result.diagnostics)
    end
    return orig_diagnostics_publish(err, result, ctx, config)
  end
end

return M
