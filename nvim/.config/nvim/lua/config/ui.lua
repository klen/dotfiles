-- Set colorscheme
vim.cmd.colorscheme('covid19')

-- Enable the new UI features in Neovim 0.10+
if vim.fn.has("nvim-0.12") == 1 then
  require('vim._core.ui2').enable({
    enable = true,
    msg = {
      target = 'cmd',
      cmd = { height = 0.5 },
      pager = { height = 0.5 },
      dialog = { height = 0.5 },
      msg = { height = 0.5, timeout = 3000 },
    }
  })
end
