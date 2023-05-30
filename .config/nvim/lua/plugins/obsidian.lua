-- https://github.com/epwalsh/obsidian.nvim

local vault = vim.fn.expand "~" .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/kk"

return {
  "epwalsh/obsidian.nvim",
  event = { "BufReadPre " .. vault .. "/**.md" },
  cmd = {
    "ObsidianBacklinks",
    "ObsidianToday",
    "ObsidianYesterday",
    "ObsidianOpen",
    "ObsidianNew",
    "ObsidianSearch",
    "ObsidianQuickSwitch",
    "ObsidianLink",
    "ObsidianLinkNew",
    "ObsidianFollowLink",
    "ObsidianTemplate",
  },
  keys = {
    { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "New Note" },
    { "<leader>nd", "<cmd>ObsidianToday<cr>", desc = "Daily Note" },
    { "<leader>ng", "<cmd>ObsidianSearch<cr>", desc = "Grep Note" },
    { "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>", desc = "Search Note" },
    { "<leader>nt", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- Optional, for completion.
    "hrsh7th/nvim-cmp",

    -- Optional, for search and quick-switch functionality.
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    dir = vault,
    daily_notes = {
      folder = "journal/daily",
    },
    templates = {
      subdir = "meta/templates",
    },
    completion = {
      nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
    },
    open_app_foreground = true,
  },
}
