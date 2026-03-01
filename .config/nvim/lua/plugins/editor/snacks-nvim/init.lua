return {
  "folke/snacks.nvim",

  keys = {
    {
      "<leader>fn",
      function()
        require("snacks").picker.notifications()
      end,
      desc = "Notification History",
    },
    {
      "<leader>fh",
      function()
        require("snacks").picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>gh",
      function()
        require("snacks").gitbrowse()
      end,
      desc = "Git Browse",
    },
    -- Keep fugitive shortcuts
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
    { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git Diff" },
    { "<leader>gl", "<cmd>Gclog -- %<cr>", desc = "Git Buffer History" },
    { "<leader>gL", "<cmd>Gclog<cr>", desc = "Git History" },
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
  init = function()
    local Snacks = require("snacks")

    Snacks.util.set_hl({
      Dir = "Directory",
    }, { prefix = "SnacksPicker", default = true })
  end,
}
