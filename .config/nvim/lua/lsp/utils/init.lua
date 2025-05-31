require "tools/table"

local M = {}
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local lsp = vim.lsp

function M.diagnostics()
  -- Doesnt support buffer
  -- vim.diagnostic.setqflist { open = false, namespace = "textDocument" }
  local bufnr = api.nvim_get_current_buf()
  local items = vim.diagnostic.toqflist(vim.diagnostic.get(bufnr))
  fn.setqflist({}, " ", {
    title = "Diagnostics",
    items = items,
  })
end

function M.process(err, result, ctx, cb)
  if err then
    return vim.notify(err.message, vim.log.levels.ERROR, { title = "LSP" })
  end
  if result and not vim.tbl_isempty(result) then
    cb(result)
  else
    return vim.notify(ctx.method .. " Not Found", vim.log.levels.WARN, { title = "LSP" })
  end
end

-- item = { col, lnum, filename, text }
function M.processLocations(err, result, ctx, cfg)
  M.process(err, result, ctx, function()
    local win = api.nvim_get_current_win()
    local client = lsp.get_client_by_id(ctx.client_id)
    if not client then
      return vim.notify(
        string.format("LSP[%s] client has shut down after sending the message", ctx.client_id),
        vim.log.levels.ERROR
      )
    end
    local items = lsp.util.locations_to_items(result, client.offset_encoding)
    local ranges = vim.tbl_map(function(loc)
      return loc.range
    end, result)
    if cfg and cfg.jump and #result == 1 then
      return M.jumpLocation(result[1], client.offset_encoding)
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
    lsp.buf.format { timeout_ms = 5000 }
  end
end

function M.jumpLocation(location, offset_encoding)
  local uri = location.uri or location.targetUri
  if uri == nil then
    return
  end
  if api.nvim_get_current_buf() ~= vim.uri_to_bufnr(uri) then
    cmd "abo split"
  end
  lsp.util.show_document(location, offset_encoding)
end

-- Detect if range or not
function M.format(line1, line2)
  if line2 == line1 then
    lsp.buf.format { timeout_ms = 5000 }
  else
    lsp.buf.range_formatting()
  end
end

-- TODO

local function lsp_request(method, handler)
  local buf = api.nvim_get_current_buf()
  local params = lsp.util.make_position_params(0, 'utf-8')
  -- params.context = { includeDeclaration = true }
  lsp.buf_request(buf, method, params, function(err, m, result)
    result = method == m and result or m
    M.process(err, result, { bufnr = buf }, handler)
  end)
end

function M.getDocumentSymbols()
  local buf = api.nvim_get_current_buf()
  lsp_request("textDocument/documentSymbol", function(result)
    local win = api.nvim_get_current_win()
    local items = lsp.util.symbols_to_items(result, buf)
    fn.setloclist(win, {}, " ", {
      title = "Diagnostics",
      items = items,
    })
    cmd "abo lw"
  end)
end

function M.showMessage(_, result, ctx, _)
  local message_type = result.type
  local message = result.message
  local client_id = ctx.client_id
  local client = lsp.get_client_by_id(client_id)
  local client_name = client and client.name or string.format("id=%d", client_id)
  if not client then
    return vim.notify(
      string.format("LSP[%s] client has shut down after sending the message", client_name),
      vim.log.levels.ERROR
    )
  end
  vim.notify(message, message_type)
end

function M.logMessage(_, result, ctx, _)
  local message_type = result.type
  local message = result.message
  local client_id = ctx.client_id
  local client = lsp.get_client_by_id(client_id)
  local client_name = client and client.name or string.format("id=%d", client_id)
  if not client then
    return vim.notify(
      string.format("LSP[%s] client has shut down after sending the message", client_name),
      vim.log.levels.ERROR
    )
  end
  local level = lsp.protocol.MessageType[message_type] or "Info"
  vim.api.nvim_echo({ { message, level .. "Msg" } }, true, {})
end

vim.api.nvim_create_augroup("lsp", { clear = true })
vim.api.nvim_create_autocmd(
  "DiagnosticChanged",
  { pattern = "*", callback = M.diagnostics, group = "lsp" }
)

return M
