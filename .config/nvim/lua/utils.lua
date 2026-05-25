local M = {} -- Module table to export functions

-- Pretty print any number of arguments using vim.inspect.
M.pprint = function(...)
  local args = { ... }
  local output = {}
  for _, arg in ipairs(args) do
    table.insert(output, vim.inspect(arg))
  end
  print(table.concat(output, " "))
end

--- Saves the current file without triggering autocommands if modified.
-- @return boolean: True if the file was saved (and expanded path is not empty), false otherwise.
M.fast_save = function()
  if vim.o.modified then
    vim.cmd("noautocmd write") -- Write buffer without triggering BufWriteCmd/BufWritePre
  end
  -- Return true if the buffer has a file name, indicating it's a "real" file
  return vim.fn.expand("%") ~= ""
end

-- Safely require a module and apply a function to it if successful.
M.safe_require = function(module_name, fn, fallback)
  local status, module = pcall(require, module_name)
  if not status then
    if fallback then
      return fallback()
    end
    vim.notify("Failed to load module: " .. module_name, vim.log.levels.WARN)
    return nil
  end
  return fn(module)
end

M.augroups = {}

M.autogroup = function(name, opts)
  if not M.augroups[name] then
    M.augroups[name] = vim.api.nvim_create_augroup('user_' .. name, opts or { clear = true })
  end
  return M.augroups[name]
end

function M.qf_from_cmd(title, cmd, efm)
  local lines = vim.fn.systemlist(cmd .. " 2>&1")
  local code = vim.v.shell_error

  if #lines == 0 and code ~= 0 then
    vim.notify(("Error running command (%d): %s"):format(code, cmd), vim.log.levels.ERROR)
    return
  end

  vim.fn.setqflist({}, " ", { title = title, lines = lines, efm = efm })
  if #vim.fn.getqflist() > 0 then
    vim.cmd("copen")
  else
    vim.cmd("cclose")
    vim.notify(title .. ": no issues", vim.log.levels.INFO)
  end
end

return M
