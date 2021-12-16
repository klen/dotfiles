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
M.command = function(name, fn)
  cmd(string.format("command! %s %s", name, fn))
end

-- Define VIM lua command
M.lua_command = function(name, fn)
  M.command(name, "lua " .. fn)
end

M.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.input = function(keys, mode)
  api.nvim_feedkeys(M.t(keys), mode or "i", true)
end

-- Define VIM autocommand
M.au = function(event, filetype, action)
  cmd("au " .. event .. " " .. filetype .. " " .. action)
end

return M
