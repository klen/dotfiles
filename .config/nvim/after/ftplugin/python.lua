local tools = require "tools"
local breakpoint_cmd = "breakpoint()"
local cmd = vim.cmd
local fn = vim.fn

local function breakpoint()
  local lnum = fn.line "."
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
  tools.fast_save()
end

vim.wo.colorcolumn = "100"
vim.keymap.set("n", "<leader>bb", breakpoint, { buffer = true })
