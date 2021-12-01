local M = {}
local notify = require "notify"

M.git_files = function()
  local files = fn.systemlist "git ls-files"
  local items = {}
  for _, filename in pairs(files) do
    table.insert(items, { filename = filename })
  end

  local win = api.nvim_get_current_win()
  lsp.util.set_loclist(items, win)
  cmd "abo lope"
end

M.vimgrep = function()
  local pattern = fn.input("Search for pattern: ", fn.expand "<cword>")
  if pattern == "" then
    return notify("Invalid pattern", "warning")
  end
  local startdir = fn.input("Start searching from directory: ", fn.getcwd(), "dir")
  if startdir == "" then
    return notify("Invalid directory", "warning")
  end
  local filepattern = fn.input("Search in files matching pattern: ", "*.*")
  if filepattern == "" then
    return notify("Invalid pattern", "warning")
  end
  local ok = pcall(
    cmd,
    "noautocmd lvimgrep /" .. pattern .. "/gj " .. startdir .. "/**/" .. filepattern
  )
  if ok then
    cmd "abo lope"
  else
    notify("Not found: " .. pattern, "warn")
  end
end

M.toggle_number = function()
  if not vim.o.number then
    vim.o.number = true
  elseif not vim.o.relativenumber then
    vim.o.relativenumber = true
  else
    vim.o.number = false
    vim.o.relativenumber = false
  end
end

-- Detect Python VIRTUAL_ENV
M.virtualenv_bin = function()
  local venv = fn.getenv "VIRTUAL_ENV"
  if venv == vim.NIL then
    return ""
  end
  return venv .. "/bin/"
end

M.fast_save = function()
  if vim.o.modified then
    cmd "noautocmd write"
  end
  return fn.expand "%" ~= ""
end

return M
