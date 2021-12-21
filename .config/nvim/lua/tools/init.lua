-- Vim Helpers

local M = {}
local api = vim.api

-- Map VIM keys
function M.map(mode, target, source, opts)
  local buffer = table.pop(opts, "buffer")
  local bufnr = table.pop(opts, "bufnr")
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  if buffer or bufnr then
    api.nvim_buf_set_keymap(bufnr or 0, mode, target, source, options)
  else
    api.nvim_set_keymap(mode, target, source, options)
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
function M.command(name, action)
  api.nvim_command(string.format("command! %s %s", name, action))
end

-- Define VIM lua command
--- @param name string -- a command name
--- @param action string -- an lua action
function M.lua_command(name, action)
  M.command(name, "lua " .. action)
end

function M.t(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

function M.input(keys, mode)
  api.nvim_feedkeys(M.t(keys), mode or "i", true)
end

-- Define VIM autocommand
--- @param event string -- VIM event
--- @param filetype string -- a file type
--- @param action string -- an action
function M.au(event, filetype, action)
  api.nvim_command("autocmd " .. event .. " " .. filetype .. " " .. action)
end

-- Define VIM autogroup
function M.augroup(group_name, definitions)
  api.nvim_command("augroup " .. group_name)
  api.nvim_command "autocmd!"
  for _, def in ipairs(definitions) do
    M.au(def)
  end
  api.nvim_command "augroup END"
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

return M
