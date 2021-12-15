-- Languages Support

return {

  -- Syntax
  "sheerun/vim-polyglot",

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = require "setup/comment",
  },

  -- Python
  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python" },
  },
}
