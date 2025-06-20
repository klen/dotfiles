-- Neovim plugin with collection of minimal, independent, and fast Lua modules dedicated to improve Neovim
-- https://github.com/echasnovski/mini.nvim
return {
  "echasnovski/mini.nvim",
  config = function()
    -- require('mini.bufremove').setup()
    -- require('mini.base16').setup()
    -- require("mini.comment").setup()
    -- require("mini.completion").setup()
    -- require("mini.jump").setup()
    -- require("mini.misc").setup()

    -- Autopairs plugin which has minimal defaults and functionality to do per-key expression mappings
    require("mini.pairs").setup()

    -- Automatic highlighting of word under cursor (displayed after customizable delay)
    require("mini.cursorword").setup { delay = 1000 }

    -- Functions for fast and simple fuzzy matching.
    -- require("mini.fuzzy").setup()
    -- require("telescope").setup {
    --   defaults = {
    --     generic_sorter = require("mini.fuzzy").get_telescope_sorter,
    --   },
    -- }

    -- Minimal, fast, and flexible start screen
    require "plugins.mini.starter"

    -- Minimal and fast statusline
    require "plugins.mini.statusline"

    -- require "plugins.mini.sessions"

    -- vim.highlight.create("MiniStatuslineDevinfo", { guibg = "#171717" }, false)
    -- vim.highlight.create("MiniStatuslineFilename", {}, true)
    -- vim.highlight.create("MiniStatuslineFileinfo", {}, true)

    require("mini.surround").setup {
      n_lines = 100,
    }
    -- require("mini.tabline").setup()
    -- require("mini.trailspace").setup()
  end,
}
