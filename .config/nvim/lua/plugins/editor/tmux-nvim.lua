return {
  -- Tmux integration for Neovim to share clipboard and more
  "aserowy/tmux.nvim",
  keys = {
    {
      "<C-h>",
      function()
        require("tmux").move_left()
      end,
      desc = "Go to left window",
    },
    {
      "<C-j>",
      function()
        require("tmux").move_bottom()
      end,
      desc = "Go to lower window",
    },
    {
      "<C-k>",
      function()
        require("tmux").move_top()
      end,
      desc = "Go to upper window",
    },
    {
      "<C-l>",
      function()
        require("tmux").move_right()
      end,
      desc = "Go to right window",
    },
  },
  opts = {
    copy_sync = {
      enable = false, -- Disable automatic synchronization of clipboard between Neovim and Tmux
    },
  },
}
