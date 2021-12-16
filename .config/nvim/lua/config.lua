-- Basic configurations

return {
  -- Color theme
  colorscheme = "jellybeans2",
  background = "dark",

  -- LSP settings
  lsp = {
    diagnostic = {
      -- See :help vim.diagnostic.config()
      config = {
        underline = false,
      },
      -- Customize signs
      signs = {
        error = "EE",
        warn = "WW",
        info = "II",
        hint = "HH",
      },
    },
    formatOnSave = false,
    filetypes = {
      javascript = {},
      lua = {},
      python = {},
    },
  },
}
