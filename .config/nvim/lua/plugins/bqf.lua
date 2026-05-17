vim.pack.add({
  'https://github.com/kevinhwang91/nvim-bqf'
})


require('bqf').setup({
  func_map = {
    vsplit = "<C-v>",
    split = "<C-s>",
    tabnew = "<C-t>",
    stoggleup = "<C-u>",
  },
})
