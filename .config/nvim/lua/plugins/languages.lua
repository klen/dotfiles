-- Languages Support

return {

  -- Syntax
  "sheerun/vim-polyglot",

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = require "configs/comment",
  },

  -- Python
  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python" },
  },
}
