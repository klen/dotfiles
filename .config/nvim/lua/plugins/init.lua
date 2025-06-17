-- Setup plugins

local lazy = require "plugins/lazy"

lazy.setup {
  spec = {
    -- NVIM Development tools
    { "folke/lazydev.nvim", ft = "lua", opts = {} },

    -- Colors
    require "plugins/colors",

    -- UI
    require "plugins/ui",

    -- Code editing
    require "plugins/code",

    -- LSP and completion
    require "plugins/lsp",

    require "plugins/mini",

  },
  defaults = {
    version = false,
  },
  install = {
    colorscheme = { "habamax", "tokyonight" },
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}
