-- Syntax highligting
vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

-- vim.cmd('syntax off')

require('nvim-treesitter').setup()
require('nvim-treesitter').install {
  'bash',
  'c_sharp',
  'diff',
  'dockerfile',
  'go',
  'haskell',
  'html',
  'htmldjango',
  'http',
  'javascript',
  'jinja',
  'jinja_inline',
  'json',
  'json5',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'nginx',
  'python',
  'ruby',
  'rust',
  'tmux',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'yaml',
  'zig',
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
