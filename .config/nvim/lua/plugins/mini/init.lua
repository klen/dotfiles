-- Neovim plugin with collection of minimal, independent, and fast Lua modules dedicated to improve Neovim
-- https://github.com/echasnovski/mini.nvim
return {
  {
    "echasnovski/mini.diff",
    opts = {}
  },
  {
    "echasnovski/mini.pairs",
    opts = {}
  },
  {
    "echasnovski/mini.cursorword",
    opts = {
      delay = 1000, -- Highlight word under cursor after 1 second
    }
  },
  {
    "echasnovski/mini.surround",
    opts = {
      n_lines = 100,
    }
  },

  -- Icon Provider
  {
    "echasnovski/mini.icons",
  },

  -- Minimal, fast, and flexible start screen
  require "plugins.mini.starter",

  -- Minimal and fast statusline
  require "plugins.mini.statusline"
}
