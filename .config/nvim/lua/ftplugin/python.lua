local u = require "utils"

local M = {}
local t = require "utils/tools"
local breakpoint_cmd = "breakpoint()"

function M.breakpoint(lnum)
  local line = fn.getline(lnum)
  if not line then
    return
  end
  if string.find(line, breakpoint_cmd) then
    cmd "normal dd"
  else
    local plnum = fn.prevnonblank(lnum)
    local indent
    if vim.o.expandtab then
      indent = fn["repeat"](" ", fn.indent(plnum))
    else
      indent = fn["repeat"]("\t", plnum / vim.o.expandtab)
    end
    fn.append(lnum - 1, indent .. breakpoint_cmd)
    cmd "normal k"
  end
  t.fast_save()
end

function M.setup()
  vim.wo.colorcolumn = "100"
  u.lua_command("-buffer Breakpoint", "require('ftplugin/python').breakpoint(fn.line('.'))")
  u.nmap("<leader>bb", "<cmd>Breakpoint<CR>", { buffer = true })
end

return M
