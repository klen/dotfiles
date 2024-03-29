-- User configuration
local Config = require "tools.config"

local severity = vim.diagnostic.severity
local signs = {
  [severity.ERROR] = "EE",
  [severity.WARN] = "WW",
  [severity.INFO] = "II",
  [severity.HINT] = "HH",
}

local cfg = Config:init {

  -- Enable debug mode
  debug = false,

  -- Keymaps
  keymaps = {},

  -- Plugins
  ----------
  null_ls = {
    disable = {
      formatting = { "prettier" },
    },
  },

  -- Colors
  ---------
  colorscheme = "covid19",
  background = "dark",

  -- Diagnostic
  -------------
  diagnostic = {
    -- See :help vim.diagnostic.config()
    config = {
      -- underline = false,
      underline = {
        severity = { min = severity.ERROR },
      },
      virtual_text = {
        severity = { min = severity.WARN },
        format = function(e)
          local code = e.user_data and e.user_data.lsp and e.user_data.lsp.code
          return string.format("%s: %s", code and string.format("%s: ", code) or "", e.message)
        end,
      },
    },
    -- Customize signs
    signs = signs,
  },
}

return cfg
