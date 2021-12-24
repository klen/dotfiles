-- Basic configurations
local Config = require "tools.config"
local severity = vim.diagnostic.severity

return Config:init {

  -- Colors
  ---------
  colorscheme = "covid19",
  background = "dark",

  -- Diagnostic
  -------------
  diagnostic = {
    -- See :help vim.diagnostic.config()
    config = {
      underline = false,
      virtual_text = {
        severity = { min = severity.WARN },
      },
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
  ---------------
  lsp = {
    format_on_save = true,
    servers = {
      jsonls = {
        capabilities = {
          document_formatting = false,
          document_range_formatting = false,
        },
      },
      tsserver = {
        capabilities = {
          document_formatting = false,
          document_range_formatting = false,
        },
      },
      pyright = {
        capabilities = {
          document_formatting = false,
          document_range_formatting = false,
        },
        diagnostic = {
          severity = { min = severity.INFO },
        },
      },
    },
  },
}
