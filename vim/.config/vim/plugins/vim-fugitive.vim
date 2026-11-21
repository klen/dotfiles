" Git (vim-fugitive)

scriptencoding utf-8

nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gd :Gdiffsplit<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gh :GBrowse<CR>
nnoremap <silent> <leader>gl :BCommits<CR>
nnoremap <silent> <leader>gL :Commits<CR>

augroup fugitive
    autocmd!
    autocmd User FugitiveIndex nnoremap <buffer> <silent> q :close<CR>
    " Reuse fugitive's own mappings: 'o' = split, 'gO' = vsplit
    autocmd User FugitiveIndex nnoremap <buffer> <silent> <C-s> o
    autocmd User FugitiveIndex nnoremap <buffer> <silent> <C-v> gO
augroup END
