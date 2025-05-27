-- Setup diagnostic
local cfg = require "config"
vim.diagnostic.config(cfg.diagnostic)

-- Auto populate quickfix
local utils = require "lsp.utils"
vim.api.nvim_create_augroup("lsp", { clear = true })
vim.api.nvim_create_autocmd(
  "DiagnosticChanged",
  { pattern = "*", callback = utils.diagnostics, group = "lsp" }
)

-- Add root markers for all LSP servers
vim.lsp.config("*", {
  root_markers = { ".git", "Cargo.toml", "package.json", "pyproject.toml" },
})

-- Setup servers
local servers = require "lsp.servers"
local common_params = require "lsp.common"

for _, server in ipairs(servers) do
  local ok, server_params = pcall(require, "lsp.configs." .. server)
  vim.lsp.config(server, ok and server_params or common_params)
end
