local signs = {
  add = { text = "+" },
  change = { text = "~" },
  delete = { text = "-" },
  topdelete = { text = "‾" },
  changedelete = { text = "~" },
  untracked = { text = "┆" },
}

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = signs,
    signs_staged = signs,
  },
}
