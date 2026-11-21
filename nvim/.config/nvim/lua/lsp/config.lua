local M = {}

M.ensure_installed = {
  "biome",
  "lua_ls",
  "marksman",
  "pyrefly",
  "ruff",
  "rust_analyzer",
  "taplo",
  "vtsls",
  "zls",
}

M.enabled = M.ensure_installed

return M
