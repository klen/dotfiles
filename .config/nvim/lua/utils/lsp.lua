local notify = require "notify"
local M = {}

function M.diagnostics(mode) -- document|all
  local diagnostics
  if mode == "all" then
    diagnostics = lsp.diagnostic.get_all()
  else
    local buf = api.nvim_get_current_buf()
    diagnostics = { [buf] = lsp.diagnostic.get(buf) }
  end
  local ret = lsp.util.diagnostics_to_items(diagnostics)
  lsp.util.set_qflist(ret)
end

function M.process(err, result, ctx, cb)
  if err then
    return notify(err.message, "error", { title = "LSP" })
  end
  if result and not vim.tbl_isempty(result) then
    cb(result)
  else
    return notify(ctx.method .. " Not Found", "warn", { title = "LSP" })
  end
end

-- item = { col, lnum, filename, text }
function M.processLocations(err, result, ctx, _)
  M.process(err, result, ctx, function()
    local win = api.nvim_get_current_win()
    local items = lsp.util.locations_to_items(result)
    local ranges = vim.tbl_map(function(loc)
      return loc.range
    end, result)
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

-- TODO
function M.processActions(err, result, ctx, _)
  M.process(err, result, ctx, function()
    print(vim.inspect(result))
  end)
end

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
    lsp.util.set_loclist(items, win)
    cmd "abo lw"
  end)
end

return M
