-- Vim Helpers

local M = {}
local api = vim.api
local fn = vim.fn

function M.input(keys, mode)
  api.nvim_feedkeys(api.nvim_replace_termcodes(keys, true, true, true), mode or "i", true)
end

-- Reload a module
--- @param module string -- a module name
function M.reload(module)
  return require("plenary.reload").reload_module(module)
end

-- Reload a module and require it
--- @param module string -- a module name
--- @return table
function M.rrequire(module)
  M.reload(module)
  return require(module)
end

-- Check for the given path exists
function M.local_plugin(path, source)
  return (fn.isdirectory(fn.expand(path)) == 1) and path or source
end

-- Use vimgrep to search a word
M.vimgrep = function()
  vim.ui.input({
    prompt = "Search for pattern: ",
    default = fn.expand "<cword>",
  }, function(pattern)
    if not pattern then
      return vim.notify("Invalid pattern", "warning")
    end
    vim.ui.input({
      prompt = "Start searching from directory: ",
      default = fn.getcwd(),
      completion = "dir",
    }, function(startdir)
      if not pattern then
        return vim.notify("Invalid directory", "warning")
      end
      vim.ui.input({
        prompt = "Search in files matching pattern: ",
        default = "*.*",
      }, function(filepattern)
        local ok = pcall(
          cmd,
          "noautocmd lvimgrep /" .. pattern .. "/gj " .. startdir .. "/**/" .. filepattern
        )
        if ok then
          vim.cmd "abo lope"
        else
          vim.notify("Not found: " .. pattern, "warn")
        end
      end)
    end)
  end)
end

-- Toggle `number` option
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

-- Fast save file
M.fast_save = function()
  if vim.o.modified then
    vim.cmd "noautocmd write"
  end
  return vim.fn.expand "%" ~= ""
end

-- Show synstack
M.synstack = function()
  for _, value in ipairs(vim.fn.synstack(vim.fn.line ".", vim.fn.col ".")) do
    pprint(vim.fn.synIDattr(value, "name"))
  end
end

return M
