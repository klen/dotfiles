-- Syntax highligting
vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter', branch = 'main' } })

-- vim.cmd('syntax off')

local ts = require('nvim-treesitter')
ts.setup()
ts.install {
  'bash',
  'c_sharp',
  'diff',
  'dockerfile',
  'go',
  'graphql',
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
  pattern = '*',
  callback = function(args)
    local ok
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype

    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then return end

    ok, _ = pcall(vim.treesitter.language.add, lang)
    if not ok then return end

    ok, _ = pcall(vim.treesitter.start, bufnr, lang)
    if not ok then return end

    -- folding, provided by nvim-treesitter
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
