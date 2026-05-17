local terminal = require 'snacks.terminal'

vim.keymap.set('n', '<C-/>', function() terminal() end, { desc = 'Open terminal' })
vim.keymap.set('n', '<C-_>', function() terminal() end)

return {
  enabled = true,
  win = {
    style = "terminal",
    keys = {
      hide_slash = { "<C-/>", "hide", desc = "Hide Terminal", mode = "t" },
      hide_underscore = { "<c-_>", "hide", mode = "t" },
    },
  },
}
