local utils = require("utils")

vim.wo.colorcolumn = "100"

-- Toggle a breakpoint on the current line. If a breakpoint already exists, it will be removed.
--
local breakpoint_template = "breakpoint()"

local function breakpoint()
  local lnum = vim.fn.line(".")
  local line = vim.fn.getline(lnum)
  if not line then
    return
  end
  if string.find(line, breakpoint_template) then
    vim.cmd("normal dd")
  else
    local plnum = vim.fn.prevnonblank(lnum)
    local indent
    if vim.o.expandtab then
      indent = vim.fn["repeat"](" ", vim.fn.indent(plnum))
    else
      indent = vim.fn["repeat"]("\t", plnum / vim.o.expandtab)
    end
    vim.fn.append(lnum - 1, indent .. breakpoint_template)
    vim.cmd("normal k")
  end
  utils.fast_save()
end

vim.keymap.set("n", "<leader>db", breakpoint, { buffer = true, desc = "Toggle Breakpoint" })

-- Check the current file with ruff and display the results in the quickfix list.
vim.api.nvim_create_user_command("RuffQF", function()
  utils.qf_from_cmd(
    "Ruff",
    "uv run ruff check --output-format=concise",
    -- type: file:line:column: message
    "%f:%l:%c: %m"
  )
end, {})

vim.api.nvim_create_user_command("PyreflyQF", function()
  utils.qf_from_cmd(
    "Pyrefly",
    "uv run pyrefly check --output-format min-text",
    -- type: file:line:column - message
    "%t%*[A-Z ] %f:%l:%c-%*[^:]: %m"
  )
end, {})

vim.api.nvim_create_user_command("MypyQF", function()
  utils.qf_from_cmd(
    "Mypy",
    "uv run mypy --hide-error-context --show-column-numbers --no-color-output",
    -- file:line:column: type: message
    "%f:%l:%c: %t%*[^:]: %m"
  )
end, {})
