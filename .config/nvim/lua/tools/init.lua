-- Vim Helpers

local M = {}

-- Map VIM keys
M.map = function(mode, target, source, opts)
  local buffer = table.pop(opts, "buffer")
  local bufnr = table.pop(opts, "bufnr")
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  if buffer or bufnr then
    vim.api.nvim_buf_set_keymap(bufnr or 0, mode, target, source, options)
  else
    vim.api.nvim_set_keymap(mode, target, source, options)
  end
end

for _, mode in ipairs { "n", "o", "i", "x", "t", "v", "c" } do
  M[mode .. "map"] = function(...)
    M.map(mode, ...)
  end
end

-- Define VIM command
--- @param name string -- a command name
--- @param action string -- an action
M.command = function(name, action)
  cmd(string.format("command! %s %s", name, action))
end

-- Define VIM lua command
--- @param name string -- a command name
--- @param action string -- an lua action
M.lua_command = function(name, action)
  M.command(name, "lua " .. action)
end

M.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.input = function(keys, mode)
  api.nvim_feedkeys(M.t(keys), mode or "i", true)
end

-- Define VIM autocommand
--- @param event string -- VIM event
--- @param filetype string -- a file type
--- @param action string -- an action
M.au = function(event, filetype, action)
  cmd("au " .. event .. " " .. filetype .. " " .. action)
end

-- Reload a module
--- @param module string -- a module name
M.reload = function(module)
  return require("plenary.reload").reload_module(module)
end

-- Reload a module and require it
--- @param module string -- a module name
--- @return table
M.rrequire = function(module)
  M.reload(module)
  return require(module)
end

return M
