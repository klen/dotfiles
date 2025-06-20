return {
  require('plugins/ui/incline'),
  require('plugins/ui/snacks'),

  --- File Explorer ---
  -- `nvim-neo-tree/neo-tree.nvim`: A modern, fast, and highly customizable file explorer tree.
  -- This is a popular choice for navigating project files within Neovim.
  require("plugins/ui/neo-tree"),

  --- Icons ---
  -- `nvim-tree/nvim-web-devicons`: Provides file type icons for various plugins
  -- (like Neo-tree, statuslines, etc.) by leveraging the Nerd Fonts.
  require("plugins/ui/nvim-web-devicons"),

  --- Notifications and UI Messaging ---
  -- `folke/noice.nvim`: A highly customizable plugin for Neovim's messages,
  -- command line, and UI, making them more modern and less intrusive.
  require("plugins/ui/noice"),

  -- `dstein64/nvim-scrollview`: Provides a minimap/overview of the current buffer,
  -- often showing cursor position and diagnostics.
  require("plugins/ui/nvim-scrollview"),

  --- Keymap Display ---
  -- `folke/which-key.nvim`: Shows a pop-up with possible keybindings
  -- as you type, making it easier to discover and remember mappings.
  require("plugins/ui/which-key"),

  --- Quickfix and Location Lists ---
  -- `kevinhwang91/nvim-bqf`: Enhances the built-in quickfix (`:copen`)
  -- and location (`:lopen`) lists with better UI and functionality.
  require("plugins/ui/nvim-bfq"),

  --- Terminal Management ---
  -- `akinsho/toggleterm.nvim`: A versatile plugin for managing multiple
  -- terminal windows (e.g., floating, horizontal, vertical splits)
  -- that can be easily toggled.
  require("plugins/ui/toggle-term"),

  --- Code Structure Explorer (Commented Out) ---
  -- `simonok/symbols-outline.nvim`: A plugin to display an outline of
  -- symbols (functions, classes, variables) in the current file, often
  -- using LSP information. It's currently disabled.
  -- require "plugins/ui/symbols-outline",
}
