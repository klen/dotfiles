local M = {} -- Module table to export functions
local fn = vim.fn

--- Saves the current file without triggering autocommands if modified.
-- @return boolean: True if the file was saved (and expanded path is not empty), false otherwise.
M.fast_save = function()
  if vim.o.modified then
    vim.cmd("noautocmd write") -- Write buffer without triggering BufWriteCmd/BufWritePre
  end
  -- Return true if the buffer has a file name, indicating it's a "real" file
  return fn.expand("%") ~= ""
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
    (fn.isdirectory(fn.expand(dir)) == 1) and { dir = dir } or { url = url }
  )
end

return M
