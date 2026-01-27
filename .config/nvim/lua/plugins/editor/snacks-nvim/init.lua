return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>fn",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
  },
  opts = {
    dashboard = require("plugins/editor/snacks-nvim/dashboard"),
    indent = require("plugins/editor/snacks-nvim/indent"),
    notifier = require("plugins/editor/snacks-nvim/notifier"),
    picker = require("plugins/editor/snacks-nvim/picker"),
    toggle = require("plugins/editor/snacks-nvim/toggle"),
    bigfile = {},
    styles = {},
    quickfile = {},
    terminal = {
      win = {
        style = "terminal",
      },
    },
    scroll = {},
    words = {
      enabled = false,
    },
  },
}
