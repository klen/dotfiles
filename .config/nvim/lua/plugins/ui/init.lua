return {
  require('plugins/ui/incline'),
  require('plugins/ui/snacks'),
  require('plugins/ui/nvim-ufo'),

  --- File Explorer ---
  require("plugins/ui/neo-tree"),

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
  --
  {
    "aserowy/tmux.nvim",
    opts = {}
  }
}
