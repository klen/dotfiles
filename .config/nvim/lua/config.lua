-- Basic configurations
local severity = vim.diagnostic.severity

return {
  -- Color theme
  colorscheme = "jellybeans2",
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
    filetypes = {
      javascript = {},
      lua = {},
      python = {},
      html = {
        format_on_save = false,
      },
    },
  },
}
