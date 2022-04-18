return {
  "neovim/nvim-lspconfig",
  requires = {
    -- Configure semneko lua
    { "folke/lua-dev.nvim", module = "lua-dev" },
  },
  config = function()
    local cfg = require("config").diagnostic
    local utils = require "plugin.lsp.utils"

    -- Setup diagnostic
    vim.diagnostic.config(cfg.config)

    -- Setup diagnostic signs
    fn.sign_define("DiagnosticSignError", { text = cfg.signs[1], texthl = "DiagnosticSignError" })
    fn.sign_define("DiagnosticSignWarn", { text = cfg.signs[2], texthl = "DiagnosticSignWarn" })
    fn.sign_define("DiagnosticSignInfo", { text = cfg.signs[3], texthl = "DiagnosticSignInfo" })
    fn.sign_define("DiagnosticSignHint", { text = cfg.signs[4], texthl = "DiagnosticSignHint" })

    -- Auto populate quickfix
    vim.api.nvim_create_augroup("lsp", { clear = true })
    vim.api.nvim_create_autocmd(
      "DiagnosticChanged",
      { pattern = "*", callback = utils.diagnostics, group = "lsp" }
    )
  end,
}
