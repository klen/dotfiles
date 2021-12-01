require "configs/neoscroll"

return {
  {
    "kevinhwang91/nvim-bqf",
    requires = {
      "junegunn/fzf",
      run = function()
        fn["fzf#install"]()
      end,
    },
    ft = "qf",
    config = require "configs/bqf",
  },
  "rcarriga/nvim-notify",
  {
    "folke/which-key.nvim",
    config = require "configs/which-key",
  },

  -- repeat surround motions with .
  "tpope/vim-surround",
  "tpope/vim-repeat",
  {
    "karb94/neoscroll.nvim",
    module = "neoscroll",
  },
}
