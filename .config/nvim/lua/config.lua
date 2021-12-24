-- Basic configurations
local Config = require "tools.config"
local severity = vim.diagnostic.severity

return Config:init {
  -- Color theme
  colorscheme = "covid19",
  background = "dark",

  -- Diagnostic
  diagnostic = {
    -- See :help vim.diagnostic.config()
    config = {
      underline = false,
    },
    -- Customize signs
    signs = {
      [severity.ERROR] = "EE",
      [severity.WARN] = "WW",
      [severity.INFO] = "II",
      [severity.HINT] = "HH",
    },
  },

  -- LSP settings
  lsp = {
    format_on_save = true,
    servers = {
      jsonls = {
        document_formatting = false,
        document_range_formatting = false,
      },
      tsserver = {
        document_formatting = false,
        document_range_formatting = false,
      },
      pyright = {
        document_formatting = false,
        document_range_formatting = false,
      },
    },
  },
}
