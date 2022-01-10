return {
  "echasnovski/mini.nvim",
  -- function name in status line
  requires = "SmiteshP/nvim-gps",
  config = function()
    -- require('mini.bufremove').setup()
    -- require('mini.base16').setup()
    -- require("mini.comment").setup()
    -- require("mini.completion").setup()
    -- require("mini.cursorword").setup()
    -- require("mini.fuzzy").setup()
    -- require("mini.jump").setup()
    -- require("mini.misc").setup()
    require("mini.pairs").setup()
    require "plugin.mini.sessions"
    require "plugin.mini.starter"
    require "plugin.mini.statusline"

    -- vim.highlight.create("MiniStatuslineDevinfo", { guibg = "#171717" }, false)
    -- vim.highlight.create("MiniStatuslineFilename", {}, true)
    -- vim.highlight.create("MiniStatuslineFileinfo", {}, true)

    -- require("mini.surround").setup()
    -- require("mini.tabline").setup()
    -- require("mini.trailspace").setup()
  end,
}
