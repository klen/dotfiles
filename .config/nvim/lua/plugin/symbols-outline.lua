-- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
-- https://github.com/simrat39/symbols-outline.nvim
return {
  "simrat39/symbols-outline.nvim",
  cmd = {
    "SymbolsOutline",
    "SymbolsOutlineOpen",
    "SymbolsOutlineClose",
  },
  config = function()
    vim.g.symbols_outline = {
      highlight_hovered_item = true,
      show_guides = true,
      position = "right",
      keymaps = {
        close = "<Esc>",
        goto_location = "<CR>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        rename_symbol = "r",
        code_actions = "a",
      },
      lsp_blacklist = {},
    }
  end,
}
