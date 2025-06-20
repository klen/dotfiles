local lazy = require("plugins/lazy") -- Assuming 'plugins/lazy.lua' contains the lazy.nvim setup

lazy.setup({
  -- Define your plugin specifications
  spec = {
    -- Neovim Development Tools
    {
      "folke/lazydev.nvim",
      ft = "lua", -- Load this plugin for Lua filetypes
      opts = {},  -- No specific options needed for lazydev.nvim
      -- lazydev.nvim provides development utilities for Neovim's Lua environment,
      -- such as enhancing LSP capabilities for Neovim's API.
    },

    -- Custom Plugins
    -- This line imports plugin definitions from the 'plugins' directory.
    -- Each file in 'plugins/' can define its own set of LazyVim plugin specs.
    { import = "plugins" },
  },

  -- Default settings for all plugins
  defaults = {
    version = false, -- Disable automatic version locking for plugins by default.
    -- This means plugins will update to their latest compatible version.
  },

  -- Installation options
  install = {
    -- Set default colorschemes to apply after installation.
    -- If 'habamax' is not available, 'tokyonight' will be tried.
    colorscheme = { "habamax", "tokyonight" },
  },

  -- Performance optimizations
  performance = {
    rtp = {
      -- Disable specific built-in runtimepath plugins that are rarely used
      -- or can be replaced by more powerful alternatives, improving startup time.
      disabled_plugins = {
        'gzip',      -- For handling gzip files
        'tarPlugin', -- For tar archives
        'tohtml',    -- For converting buffer to HTML
        'tutor',     -- The Vim tutor
        'zipPlugin', -- For zip archives
      },
    },
  },
})
