" LSP client (yegappan/lsp)
" The server list and options live under lsp/, the file here only pulls them in.

scriptencoding utf-8

execute 'source' fnameescape(expand('<sfile>:p:h') . '/../lsp/init.vim')

nnoremap <silent> <leader>od <Cmd>LspDiag highlight toggle<CR>
