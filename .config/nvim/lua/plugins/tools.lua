require "setup/neoscroll"

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
    config = require "setup/bqf",
  },
  "rcarriga/nvim-notify",
  {
    "folke/which-key.nvim",
    config = require "setup/which-key",
  },

  -- repeat surround motions with .
  "tpope/vim-surround",
  "tpope/vim-repeat",
  {
    "karb94/neoscroll.nvim",
    module = "neoscroll",
  },
}
