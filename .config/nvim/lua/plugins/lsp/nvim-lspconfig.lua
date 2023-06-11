return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("neodev").setup {
      -- add any options here, or leave empty to use the default settings
      -- override = function(_, library)
      --   library.enabled = true
      --   library.plugins = true
      -- end,
    }

    -- Setup diagnostic
    local cfg = require "config"
    local diagnostic = cfg.diagnostic
    vim.diagnostic.config(diagnostic.config)

    -- Setup diagnostic signs
    local fn = vim.fn
    fn.sign_define(
      "DiagnosticSignError",
      { text = diagnostic.signs[1], texthl = "DiagnosticSignError" }
    )
    fn.sign_define(
      "DiagnosticSignWarn",
      { text = diagnostic.signs[2], texthl = "DiagnosticSignWarn" }
    )
    fn.sign_define(
      "DiagnosticSignInfo",
      { text = diagnostic.signs[3], texthl = "DiagnosticSignInfo" }
    )
    fn.sign_define(
      "DiagnosticSignHint",
      { text = diagnostic.signs[4], texthl = "DiagnosticSignHint" }
    )

    -- Auto populate quickfix
    local utils = require "lsp.utils"
    vim.api.nvim_create_augroup("lsp", { clear = true })
    vim.api.nvim_create_autocmd(
      "DiagnosticChanged",
      { pattern = "*", callback = utils.diagnostics, group = "lsp" }
    )

    -- Setup servers
    local lspconfig = require "lspconfig"
    local servers = require "lsp.servers"
    local common_params = require "lsp.common"

    for _, server in ipairs(servers) do
      local ok, server_params = pcall(require, "lsp.configs." .. server)
      lspconfig[server].setup(ok and server_params or common_params)
    end
  end,
}
