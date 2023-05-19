-- Setup plugins

local lazy = require "plugins/lazy"

lazy.setup {
  require "plugins/treesitter",
  require "plugins/ui",
  require "plugins/mini",
  require "plugins/lsp",
  require "plugins/code",
  require "plugins/theme",
}
