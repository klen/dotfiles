local present, lualine = pcall(require, "lualine")
if not present then
  return
end

-- Show keymap
local function keymap()
  if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
    return vim.b.keymap_name:upper()
  end
  return ""
end

lualine.setup {
  options = {
    icons_enabled = false,
    theme = "powerline",
    disabled_filetypes = {
      "toggleterm",
      "NvimTree",
      "vista_kind",
      "dapui_scopes",
      "dapui_breakpoints",
      "dapui_stacks",
      "dapui_watches",
      "dap-repl",
    },
  },

  sections = {
    lualine_a = { "mode", keymap },
  },

  extensions = { "fugitive" },
}
