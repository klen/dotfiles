return {

  -- Treesitter helpers
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufEnter",
    cmd = {
      "TSInstall",
      "TSInstallSync",
      "TSBufEnable",
      "TSBufToggle",
      "TSEnableAll",
      "TSInstallFromGrammer",
      "TSToggleAll",
      "TSUpdate",
      "TSUpdateSync",
    },
    config = function()
      require "setup/treesitter"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- Debug
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSPlaygroundToggle",
      "TSHighlightCapturesUnderCursor",
    },
  },
}
