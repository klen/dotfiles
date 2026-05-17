vim.pack.add({
  'https://github.com/aserowy/tmux.nvim',
})

require('tmux').setup({
  copy_sync = {
    enable = false, -- Disable automatic synchronization of clipboard between Neovim and Tmux
  },

  keys = {
    {
      '<C-h>',
      function() require('tmux').move_left() end,
      desc = 'Move to left pane',
    },
    {
      '<C-j>',
      function() require('tmux').move_down() end,
      desc = 'Move to lower pane',
    },
    {
      '<C-k>',
      function() require('tmux').move_up() end,
      desc = 'Move to upper pane',
    },
    {
      '<C-l>',
      function() require('tmux').move_right() end,
      desc = 'Move to right pane',
    },
  }
})
