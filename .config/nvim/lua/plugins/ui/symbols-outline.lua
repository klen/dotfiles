-- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
-- https://github.com/simrat39/symbols-outline.nvim
vim.api.nvim_create_autocmd("FileType", { pattern = "Outline", command = "set nowrap" })

return {
  "simrat39/symbols-outline.nvim",
  cmd = {
    "SymbolsOutline",
    "SymbolsOutlineOpen",
    "SymbolsOutlineClose",
  },
  opts = {
    highlight_hovered_item = false,
    show_guides = false,
    position = "right",
    width = 40,
    keymaps = {
      close = "<Esc>",
      goto_location = "<CR>",
      focus_location = "o",
      hover_symbol = "<C-space>",
      rename_symbol = "r",
      code_actions = "a",
    },
    show_symbol_details = false,
    symbol_blacklist = {
      "File",
      "Module",
      "Namespace",
      "Package",
      -- "Class",
      -- "Method",
      "Property",
      "Field",
      "Constructor",
      "Enum",
      -- "Interface",
      -- "Function",
      "Variable",
      "Constant",
      "String",
      "Number",
      "Boolean",
      "Array",
      "Object",
      "Key",
      "Null",
      "EnumMember",
      "Struct",
      "Event",
      "Operator",
      "TypeParameter",
    },
  },
  init = function()
    local cfg = require "config"
    cfg.keymaps["<leader>ds"] = { "<cmd>SymbolsOutline<cr>", "Explore symbols" }
  end,
}
