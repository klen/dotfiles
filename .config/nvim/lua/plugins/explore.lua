return {

  -- Fuzzy finder and it requirments.
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "configs/telescope"
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    requires = { "nvim-lua/plenary.nvim" },
  },
  "artart222/telescope_find_directories",
  {
    "mrjones2014/dash.nvim",
    run = "make install",
  },

  -- File explorer tree.
  {
    "kyazdani42/nvim-tree.lua",
    cmd = {
      "NvimTreeOpen",
      "NvimTreeFocus",
      "NvimTreeToggle",
      "NvimTreeFindFile",
    },
    config = function()
      require "configs/nvim-tree"
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    config = require "configs/symbols-outline",
    cmd = {
      "SymbolsOutline",
      "SymbolsOutlineOpen",
      "SymbolsOutlineClose",
    },
  },
}
