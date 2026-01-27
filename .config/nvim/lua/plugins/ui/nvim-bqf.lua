-- Better quickfix window in Neovim, polish old quickfix window
-- https://github.com/kevinhwang91/nvim-bqf
return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  opts = {
    func_map = {
      vsplit = "<C-v>",
      split = "<C-s>",
      tabnew = "<C-t>",
      stoggleup = "<C-u>",
    },
  },
}
