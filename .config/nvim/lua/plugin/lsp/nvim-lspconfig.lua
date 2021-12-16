return {
  "neovim/nvim-lspconfig",
  requires = {
    -- Configure semneko lua
    { "folke/lua-dev.nvim", module = "lua-dev" },
  },
  config = function()
    local cfg = require "config"
    local dcfg = cfg.lsp.diagnostic

    -- Setup diagnostic
    vim.diagnostic.config(dcfg.config)

    -- Setup diagnostic signs
    fn.sign_define("DiagnosticSignError", { text = dcfg.error, texthl = "DiagnosticError" })
    fn.sign_define("DiagnosticSignWarn", { text = dcfg.warn, texthl = "DiagnosticWarn" })
    fn.sign_define("DiagnosticSignInfo", { text = dcfg.info, texthl = "DiagnosticInfo" })
    fn.sign_define("DiagnosticSignHint", { text = dcfg.hint, texthl = "DiagnosticHint" })

    -- Auto populate quickfix
    cmd [[
      augroup lsp
        autocmd!
        au DiagnosticChanged * lua require('utils/lsp').diagnostics('document')
      augroup END
    ]]
  end,
}
