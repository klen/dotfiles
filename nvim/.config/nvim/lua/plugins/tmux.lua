vim.pack.add({
  'https://github.com/aserowy/tmux.nvim',
})

require('tmux').setup({
  copy_sync = {
    enable = false, -- Disable automatic synchronization of clipboard between Neovim and Tmux
  },
})
