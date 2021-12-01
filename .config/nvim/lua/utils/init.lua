-- Vim Helpers

local get_map_options = function(custom_options)
  local options = { noremap = true, silent = true }
  if custom_options then
    options = vim.tbl_extend("force", options, custom_options)
  end
  return options
end

local M = {}

M.map = function(mode, target, source, opts)
  local buffer = table.pop(opts, "buffer")
  local bufnr = table.pop(opts, "bufnr")
  opts = get_map_options(opts)
  if buffer or bufnr then
    vim.api.nvim_buf_set_keymap(bufnr or 0, mode, target, source, opts)
  else
    vim.api.nvim_set_keymap(mode, target, source, opts)
  end
end

for _, mode in ipairs { "n", "o", "i", "x", "t", "v", "c" } do
  M[mode .. "map"] = function(...)
    M.map(mode, ...)
  end
end

M.command = function(name, fn)
  cmd(string.format("command! %s %s", name, fn))
end

M.lua_command = function(name, fn)
  M.command(name, "lua " .. fn)
end

M.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.input = function(keys, mode)
  api.nvim_feedkeys(M.t(keys), mode or "i", true)
end

M.au = function(event, filetype, action)
  cmd("au " .. event .. " " .. filetype .. " " .. action)
end

return M
