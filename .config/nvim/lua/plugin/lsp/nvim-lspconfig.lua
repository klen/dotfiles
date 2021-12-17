return {
  "neovim/nvim-lspconfig",
  requires = {
    -- Configure semneko lua
    { "folke/lua-dev.nvim", module = "lua-dev" },
  },
  config = function()
    local cfg = require("config").diagnostic

    -- Setup diagnostic
    vim.diagnostic.config(cfg.config)

    -- Setup diagnostic signs
    fn.sign_define("DiagnosticSignError", { text = cfg.signs[0], texthl = "DiagnosticSignError" })
    fn.sign_define("DiagnosticSignWarn", { text = cfg.signs[1], texthl = "DiagnosticSignWarn" })
    fn.sign_define("DiagnosticSignInfo", { text = cfg.signs[2], texthl = "DiagnosticSignInfo" })
    fn.sign_define("DiagnosticSignHint", { text = cfg.signs[3], texthl = "DiagnosticSignHint" })

    -- Auto populate quickfix
    cmd [[
      augroup lsp
        autocmd!
        au DiagnosticChanged * lua require('plugin/lsp/utils').diagnostics()
      augroup END
    ]]
  end,
}