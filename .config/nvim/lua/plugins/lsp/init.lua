return {
  --- Language Server Protocol (LSP) Management ---
  -- `mason-org/mason-lspconfig.nvim`: Integrates Mason.nvim with nvim-lspconfig
  -- to simplify the installation and setup of LSP servers.
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- Ensure these LSP servers are installed.
      -- `require "lsp.servers"` is expected to return a table of server names (e.g., {"lua_ls", "pyright"}).
      ensure_installed = require("lsp.servers"),
      automatic_installation = true, -- Automatically install missing servers
    },
    dependencies = {
      -- `mason-org/mason.nvim`: The universal package manager for Neovim.
      -- Used for managing LSP servers, DAP adapters, linters, and formatters.
      { "mason-org/mason.nvim", opts = {} },
      -- `neovim/nvim-lspconfig`: Core plugin for Neovim's LSP client, providing
      -- default configurations for various LSP servers.
      "neovim/nvim-lspconfig",
      -- `sanghen/blink.cmp`: Likely a completion plugin that integrates with LSP.
      "sanghen/blink.cmp",
    },
  },

  --- Diagnostic and Linter Configuration ---
  -- `creativenull/diagnosticls-configs-nvim`: Provides configurations for
  -- `diagnostic-languageserver` to integrate external linters and formatters
  -- into the LSP diagnostic system.
  {
    "creativenull/diagnosticls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" }, -- Requires nvim-lspconfig
  },

  -- Support for non-LSP formatters, linters, etc.
  -- This typically refers to `null-ls.nvim` (now `none-ls.nvim`) which allows
  -- integrating CLI tools for diagnostics and formatting.
  require("plugins/lsp/none-ls"),

  -- -- Support LSP status for statusline (Commented Out)
  -- -- This section is commented out, suggesting `lsp-status.nvim` is not currently in use.
  -- -- It usually provides information about the active LSP client in the statusline.
  -- require "plugins/lsp/lsp-status",

  --- AI Code Assistants ---
  require("plugins/lsp/copilot"),       -- Main Copilot plugin for Vim/Neovim
  require("plugins/lsp/codecompanion"), -- Main Copilot plugin for Vim/Neovim
  -- require("plugins/lsp/copilotchat-nvim"), -- Copilot Chat integration

  -- `LLM` Integration (Commented Out)
  -- This line is commented out, indicating another Large Language Model (LLM) plugin
  -- is not currently active.
  -- require "plugins/lsp/llm",
}
