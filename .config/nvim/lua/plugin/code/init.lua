return {
  -- Better Syntax
  "sheerun/vim-polyglot",

  -- repeat surround motions with .
  "tpope/vim-surround",
  "tpope/vim-repeat",

  -- Comment code
  require "plugin/code/comment",

  -- Git support
  require "plugin/code/vim-fugitive",

  -- Tests
  require "plugin/code/nvim-test",

  -- Snippets
  require "plugin/code/luasnip",

  -- Completion
  require "plugin/code/nvim-cmp",

  "hrsh7th/cmp-buffer", -- Buffer completion
  "hrsh7th/cmp-path", -- Path completion
  "hrsh7th/cmp-nvim-lsp", -- LSP completion
  "hrsh7th/cmp-nvim-lua", -- VIM lua API completion
  "saadparwaiz1/cmp_luasnip", -- Snippets completion

  -- Python
  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python" },
  },

  -- CoffeeScript
  "kchmck/vim-coffee-script",
}
