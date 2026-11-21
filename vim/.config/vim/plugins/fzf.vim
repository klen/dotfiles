" Fuzzy finder (fzf + fzf.vim)

scriptencoding utf-8

" Enter opens in the current window; Ctrl-X/V/T split/tab.
let g:fzf_action = {
    \ 'enter': 'edit',
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }

let g:fzf_colors = {
    \ 'fg': ['fg', 'Normal'],
    \ 'bg': ['bg', 'Normal'],
    \ 'hl': ['fg', 'Comment'],
    \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+': ['fg', 'Statement'],
    \ 'info': ['fg', 'PreProc'],
    \ 'border': ['fg', 'Ignore'],
    \ 'prompt': ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker': ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header': ['fg', 'Comment'],
    \ 'gutter': ['bg', 'Normal']
    \ }

nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>/ :Rg<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fh :Helptags<CR>
nnoremap <silent> <leader>fm :Maps<CR>
nnoremap <silent> <leader>fr :History<CR>
nnoremap <silent> <leader>fw :Rg <C-R><C-W><CR>
nnoremap <silent> <leader>fs :LspSymbolSearch<CR>
