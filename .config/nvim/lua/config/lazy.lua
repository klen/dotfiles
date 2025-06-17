local lazy = require "plugins/lazy"

lazy.setup {
  spec = {
    -- NVIM Development tools
    {
      "folke/lazydev.nvim", ft = "lua", opts = {}
    },

    -- LazyVim
    { "LazyVim/LazyVim" },

    -- Plugins
    { import = "plugins" },

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
