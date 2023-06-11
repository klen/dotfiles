-- Setup plugins

local lazy = require "plugins/lazy"

lazy.setup {
  require "plugins/ui",
  require "plugins/treesitter",
  require "plugins/lsp",
  require "plugins/code",
  require "plugins/mini",
  require "plugins/theme",
  -- require "plugins/obsidian",
}
