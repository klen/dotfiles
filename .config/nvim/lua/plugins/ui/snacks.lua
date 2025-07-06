return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {},
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
    picker = {},
    styles = {},
    lazygit = {
      win = {
        width = function()
          return vim.o.columns - 2
        end,
        height = function()
          return vim.o.lines - 2
        end,
      }
    }
  },
  keys = {
    { "<leader>bd", function() require('snacks').bufdelete() end,                    desc = "Delete Buffer" },
    { "<leader>fp", function() require('snacks').picker() end,                       desc = "Choose picker" },
    { "<leader>ff", function() require('snacks').picker.smart() end,                 desc = "Find File" },
    { "<leader>fg", function() require('snacks').picker.grep() end,                  desc = "Find Text" },
    { "<leader>fb", function() require('snacks').picker.buffers() end,               desc = "List Buffers" },
    { "<leader>fh", function() require('snacks').picker.help() end,                  desc = "Help Tags" },
    { "<leader>fr", function() require('snacks').picker.recent() end,                desc = "Recent Files" },
    { "<leader>fd", function() require('snacks').picker.diagnostics() end,           desc = "Diagnostics" },
    { "<leader>fk", function() require('snacks').picker.keymaps() end,               desc = "Keymaps" },
    { "<leader>fs", function() require('snacks').picker.lsp_symbols() end,           desc = "LSP Symbols" },
    { "<leader>fS", function() require('snacks').picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    { "<leader>gB", function() require('snacks').picker.git_branches() end,          desc = "Git Branches" },
    { "<leader>gg", function() require('snacks').lazygit() end,                      desc = "Lazygit" },
    { "<leader>gl", function() require('snacks').lazygit.log() end,                  desc = "Git Log" },
    { "<leader>gf", function() require('snacks').lazygit.log_file() end,             desc = "Git Log File" },
    { "<leader>go", function() require('snacks').gitbrowse() end,                    desc = "Git Browse" },
    { "<leader>gr", function() require('snacks').gitbrowse({ what = "repo" }) end,   desc = "Git Browse Repo" },
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
