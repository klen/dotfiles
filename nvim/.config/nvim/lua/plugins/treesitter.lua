-- Syntax highligting
vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter', branch = 'main' } })

-- vim.cmd('syntax off')

local ts = require('nvim-treesitter')
ts.setup()

-- `tmux` is no longer in nvim-treesitter `main`, and `kulala_http` is installed
-- by kulala.nvim into the shared parser dir. Teach nvim-treesitter about both
-- so `:TSUpdate` can resolve and update them instead of erroring.
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    local parsers = require('nvim-treesitter.parsers')

    parsers.tmux = {
      install_info = {
        url = 'https://github.com/Freed-Wu/tree-sitter-tmux',
        revision = '58147321fa1f00daec15dd4d371bc9e2e9373459',
        generate = true,
        generate_from_json = false,
        queries = 'queries',
      },
    }

    local ok, kulala = pcall(require, 'kulala.globals')
    if ok then
      parsers.kulala_http = {
        install_info = {
          url = kulala.TREESITTER_REPO_URL,
          revision = kulala.TREESITTER_VERSION,
        },
      }
    end
  end,
})

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
