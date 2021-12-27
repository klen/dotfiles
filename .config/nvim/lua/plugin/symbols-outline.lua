-- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
-- https://github.com/simrat39/symbols-outline.nvim
local tools = require "tools"
tools.au("FileType", "Outline", "set nowrap")

return {
  "simrat39/symbols-outline.nvim",
  cmd = {
    "SymbolsOutline",
    "SymbolsOutlineOpen",
    "SymbolsOutlineClose",
  },
  config = function()
    require("symbols-outline").setup {
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
    }
  end,
}
