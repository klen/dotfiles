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

-- Picker transform: drop items that duplicate an earlier one (same name/file/position).
-- Some LSP servers (e.g. pyrefly) return the same workspace symbol multiple times.
M.dedup_symbols = function(item, ctx)
  ctx.meta.dedup = ctx.meta.dedup or {}
  local key = table.concat({ item.name or '', item.file or '', item.pos[1], item.pos[2] }, '\0')
  if ctx.meta.dedup[key] then
    return false
  end
  ctx.meta.dedup[key] = true
end

-- Collect the code action kinds a client advertises, from both static capabilities
-- and dynamically registered ones (registered via client/registerCapability).
M.client_code_action_kinds = function(client)
  local kinds = {}

  local provider = client.server_capabilities.codeActionProvider
  if type(provider) == 'table' then
    vim.list_extend(kinds, provider.codeActionKinds or {})
  end

  for _, reg in ipairs(client.registrations.codeActionProvider or {}) do
    local opts = reg.registerOptions
    if type(opts) == 'table' then
      vim.list_extend(kinds, opts.codeActionKinds or {})
    end
  end

  return kinds
end

-- True if the client advertises `kind` or any `kind.*` sub-kind (e.g. 'source.fixAll.ruff').
M.client_supports_kind = function(client, kind)
  if not client:supports_method('textDocument/codeAction') then
    return false
  end
  for _, k in ipairs(M.client_code_action_kinds(client)) do
    if k == kind or vim.startswith(k, kind .. '.') then
      return true
    end
  end
  return false
end

-- Request and apply a code action of `kind` synchronously, resolving stubs if needed.
M.apply_code_action = function(bufnr, kind)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if M.client_supports_kind(client, kind) then
      local params = {
        textDocument = vim.lsp.util.make_text_document_params(bufnr),
        range = {
          start = { line = 0, character = 0 },
          ['end'] = { line = vim.api.nvim_buf_line_count(bufnr), character = 0 },
        },
        context = { only = { kind }, diagnostics = {} },
      }

      local res = client:request_sync('textDocument/codeAction', params, 3000, bufnr)
      if res and not res.err and res.result then
        for _, action in ipairs(res.result) do
          -- Some servers (ruff) return a stub without edit/command that must be resolved.
          if not action.edit and not action.command and client:supports_method('codeAction/resolve') then
            local resolved = client:request_sync('codeAction/resolve', action, 3000, bufnr)
            if resolved and not resolved.err and resolved.result then
              action = resolved.result
            end
          end
          if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
          end
          if action.command then
            client:exec_cmd(action.command, { bufnr = bufnr, client_id = client.id })
          end
        end
      end
    end
  end
end

return M
