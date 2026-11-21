" LSP autocommands

scriptencoding utf-8

augroup lsp
    autocmd!
    autocmd User LspAttached call lsp#keymaps#attach()
    autocmd User LspDetached call lsp#keymaps#detach()
augroup END
