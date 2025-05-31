-- User configuration
local Config = require "tools.config"

local severity = vim.diagnostic.severity

local cfg = Config:init {

  -- Enable debug mode
  debug = false,

  -- Keymaps
  keymaps = {},

  -- Colors
  ---------
  colorscheme = "covid19",
  background = "dark",

  -- Diagnostic
  -------------
  -- See :help vim.diagnostic.config()
  diagnostic = {
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
    -- Customize signs
    signs = {
      text = {
        [severity.HINT] = "HH",
        [severity.INFO] = "II",
        [severity.WARN] = "WW",
        [severity.ERROR] = "EE",
      },
    },
  },
}

return cfg
