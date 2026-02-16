local M = {} -- Module table to export functions

--- Saves the current file without triggering autocommands if modified.
-- @return boolean: True if the file was saved (and expanded path is not empty), false otherwise.
M.fast_save = function()
  if vim.o.modified then
    vim.cmd("noautocmd write") -- Write buffer without triggering BufWriteCmd/BufWritePre
  end
  -- Return true if the buffer has a file name, indicating it's a "real" file
  return vim.fn.expand("%") ~= ""
end

-- Navigates to the next or previous diagnostic message with optional severity filtering.
-- @param next boolean: If true, go to the next diagnostic; if false, go to the previous.
-- @param severity string|nil: Optional severity level to filter diagnostics (e.g., "ERROR", "WARN", "INFO", "HINT").
-- @return function:
M.diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end

-- Pretty-prints a Lua table for debugging purposes.
-- @param tbl table: The table to be printed.
M.pprint = function(tbl)
  print(vim.inspect(tbl))
end

_G.pprint = M.pprint -- Make pprint globally accessible for convenience

--- Conditionally configures a plugin to be loaded from a local path or a remote URL.
-- This is useful for developing plugins locally while maintaining the option to use
-- the remote version in other environments.
function M.local_plugin(dir, url, opts)
  -- If the local path exists and is a directory, use it; otherwise, use the remote source.
  return vim.tbl_extend(
    "force", -- Forces overwrite for conflicting keys
    opts or {}, -- Start with provided options (or empty table)
    (vim.fn.isdirectory(vim.fn.expand(dir)) == 1) and { dir = dir } or { url = url }
  )
end

function M.qf_from_cmd(title, cmd, efm)
  local qf_cmd = string.format("%s 2>&1 | tee", cmd)
  local lines = vim.fn.systemlist(qf_cmd)
  if vim.v.shell_error ~= 0 then
    print("Error running command: " .. cmd)
    return
  end
  vim.fn.setqflist({}, " ", { title = title, lines = lines, efm = efm })
  vim.cmd("copen")
end

-- Jumps to a location specified by an LSP location object.
-- @param loc table: An LSP location object containing 'uri' and 'range' fields.
-- The function will open the file if it's not already open and move the cursor to the specified position.
-- If the location format is invalid, it will print an error message.
function M.jump_location(loc, offset_encoding)
  local bufnr = vim.uri_to_bufnr(loc.uri or loc.targetUri)
  local curbuf = vim.api.nvim_get_current_buf()
  if bufnr ~= curbuf then
    vim.cmd("abo split")
  end
  vim.lsp.util.show_document(loc, offset_encoding)
end

function M.lsp_on_list(result)
  if #result.items == 1 then
    ---@diagnostic disable-next-line: param-type-mismatch
    local clients = vim.lsp.get_clients(result)
    M.jump_location(result.items[1].user_data, clients[1].offset_encoding)
  else
    vim.lsp.util.set_qflist(result.items)
    vim.api.nvim_command("copen")
  end
end

return M
