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
  debug = true,

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
        diagnostic = {
          -- Disable codes
          disable = { 8006, 8008, 8010, 8011 },
        },
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

  -- Plugins
  ----------
  null_ls = {
    disable = {
      formatting = { "prettier" },
    },
  },
}
return cfg
