-- Load the configuration module
local cfg = require("config")

-- Set the global 'background' option based on your configuration.
-- This typically sets whether the colorscheme should be optimized for a "dark" or "light" background.
vim.opt.background = cfg.background

return {
  --- Colorscheme Development ---
  -- `rktjmp/lush.nvim`: A plugin for defining Neovim themes using a Lua DSL (Domain Specific Language).
  -- This makes creating and managing colorschemes more programmatic and less cumbersome.
  require("plugins/colors/lush"),

  --- Installed Colorschemes ---
  -- These lines import the configurations for various colorschemes from your 'plugins/colors/' directory.
  -- Each `require` call likely points to a Lua file that sets up and potentially configures a specific theme.
  -- require("plugins/colors/jellybeans"),
  -- require("plugins/colors/zenbones"),
  -- require("plugins/colors/codeschool"),
  -- require("plugins/colors/tokyonight"),
  -- require("plugins/colors/vscode"),

  --- LSP Colors Support ---
  -- `folke/lsp-colors.nvim`: This plugin enhances the display of LSP (Language Server Protocol) diagnostics
  -- and other related UI elements by applying specific colors, making them more distinct and readable within your chosen colorscheme.
  "folke/lsp-colors.nvim",
}
