return {
  -- Highly extendable fuzzy finder over lists
  {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  },

  -- File explorer tree.
  require "plugin/ui/nvim-tree",

  -- Code explorer
  require "plugin/ui/symbols-outline",

  -- Better loclist/qflist
  require "plugin/ui/nvim-bfq",

  -- Better scrolling
  require "plugin/ui/neoscroll",
  require "plugin/ui/nvim-scrollview",

  -- Better notifies
  require "plugin/ui/nvim-notify",

  -- UI Helpers (vim.ui.input, vim.ui.select)
  require "plugin/ui/dressing",

  -- Manage multiple terminal windows
  require "plugin/ui/toggle-term",

  -- Indent guides
  require "plugin/ui/indent-blankline",

  -- -- Search Dash.app from your Neovim fuzzy finder
  -- require "plugin/ui/dash",

  -- Show key/operators maps
  require "plugin/ui/which-key",
}
