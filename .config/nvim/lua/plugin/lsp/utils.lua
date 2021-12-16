local M = {}

function M.diagnostics()
  -- Doesnt support buffer
  -- vim.diagnostic.setqflist { open = false, namespace = "textDocument" }
  local bufnr = api.nvim_get_current_buf()
  local items = vim.diagnostic.toqflist(vim.diagnostic.get(bufnr))
  vim.fn.setqflist({}, " ", {
    title = "Diagnostics",
    items = items,
  })
end

function M.process(err, result, ctx, cb)
  if err then
    return vim.notify(err.message, "error", { title = "LSP" })
  end
  if result and not vim.tbl_isempty(result) then
    cb(result)
  else
    return vim.notify(ctx.method .. " Not Found", "warn", { title = "LSP" })
  end
end

-- item = { col, lnum, filename, text }
function M.processLocations(err, result, ctx, cfg)
  M.process(err, result, ctx, function()
    local win = api.nvim_get_current_win()
    local items = lsp.util.locations_to_items(result)
    local ranges = vim.tbl_map(function(loc)
      return loc.range
    end, result)
    if cfg and cfg.jump and #items == 1 then
      return M.jumpLocation(items[1])
    end
    -- lsp.util.set_loclist(items, win)
    fn.setloclist(
      win,
      {},
      " ",
      { items = items, title = ctx.method, context = { bqf = { lsp_ranges_hl = ranges } } }
    )
    cmd "abo lope"
  end)
end

function M.gotoDefinition(err, result, ctx, _)
  M.processLocations(err, result, ctx, { jump = true })
end

function M.processSymbols(err, result, ctx, _)
  M.process(err, result, ctx, function()
    local win = api.nvim_get_current_win()
    local items = lsp.util.symbols_to_items(result, ctx.bufnr)
    local ranges = vim.tbl_map(function(loc)
      return loc.selectionRange
    end, result)
    fn.setloclist(
      win,
      {},
      " ",
      { items = items, title = ctx.method, context = { bqf = { lsp_ranges_hl = ranges } } }
    )
    cmd "abo lope"
  end)
end

function M.processCalls(err, result, ctx, _)
  M.process(err, result, ctx, function()
    local items = {}
    local ranges = {}
    for _, call in ipairs(result) do
      call = call.to and call.to or call.from
      table.insert(items, {
        text = call.name,
        lnum = call.range.start.line,
        col = call.range.start.character,
        filename = vim.uri_to_fname(call.uri),
      })
      table.insert(ranges, call.selectionRange)
    end
    local win = api.nvim_get_current_win()
    fn.setloclist(
      win,
      {},
      " ",
      { items = items, title = ctx.method, context = { bqf = { lsp_ranges_hl = ranges } } }
    )
    cmd "abo lope"
  end)
end

function M.formatOnSave()
  if vim.o.modified then
    vim.lsp.buf.formatting_sync({}, 1000)
  end
end

function M.jumpLocation(item)
  local win = vim.api.nvim_get_current_win
  vim.cmd("edit " .. item.filename)
  vim.api.nvim_win_set_cursor(win, { item.lnum, item.col })
end

-- TODO

local function lsp_request(method, handler)
  local buf = api.nvim_get_current_buf()
  local params = lsp.util.make_position_params()
  params.context = { includeDeclaration = true }
  lsp.buf_request(buf, method, params, function(err, m, result)
    result = method == m and result or m
    M.process(err, result, { bufnr = buf }, handler)
  end)
end

function M.getDocumentSymbols()
  local buf = api.nvim_get_current_buf()
  lsp_request("textDocument/documentSymbol", function(result)
    local win = api.nvim_get_current_win()
    local items = vim.lsp.util.symbols_to_items(result, buf)
    vim.fn.setloclist(win, {}, " ", {
      title = "Diagnostics",
      items = items,
    })
    cmd "abo lw"
  end)
end

return M
