return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {},
    explorer = {
      replace_netrw = true
    },
    indent = {
      indent = {
        hl = "NonText",
      },
      scope = {
        hl = "Folded",
      },
      animate = { enabled = false },
    },
    scroll = {},
    terminal = {
      win = {
        style = "terminal",
      }
    },
    picker = {}
  },
  keys = {
    { "<leader>bd", function() require('snacks').bufdelete() end,           desc = "Delete Buffer" },
    { "<leader>fp", function() require('snacks').picker() end,              desc = "Choose picker" },
    { "<leader>ff", function() require('snacks').picker.smart() end,        desc = "Find File" },
    { "<leader>fg", function() require('snacks').picker.grep() end,         desc = "Find Text" },
    { "<leader>fb", function() require('snacks').picker.buffers() end,      desc = "List Buffers" },
    { "<leader>fh", function() require('snacks').picker.help() end,         desc = "Help Tags" },
    { "<leader>fr", function() require('snacks').picker.recent() end,       desc = "Recent Files" },
    { "<leader>fd", function() require('snacks').picker.diagnostics() end,  desc = "Diagnostics" },
    { "<leader>gl", function() require('snacks').picker.git_log() end,      desc = "Git Log" },
    { "<leader>gf", function() require('snacks').picker.git_log_file() end, desc = "Git Log File" },
    { "<leader>gb", function() require('snacks').picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gg", function() require('snacks').lazygit() end,             desc = "Lazygit" },
    -- { "<leader>gs", function() require('snacks').picker.git_status() end, desc = "Git Status" },
    -- { "<leader>gc", function() require('snacks').picker.git_commits() end, desc = "Git Commits" },
    -- { "<leader>gC", function() require('snacks').picker.git_commit() end, desc = "Git Commit" },
    -- { "<leader>gS", function() require('snacks').picker.git_stash() end, desc = "Git Stash" },
  },
  init = function()
    local Snacks = require("snacks")

    Snacks.util.set_hl({
      Dir = "Directory",
    }, { prefix = "SnacksPicker", default = true })
  end,
}
