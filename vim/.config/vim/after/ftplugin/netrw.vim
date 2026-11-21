" File browser keys for netrw

" l/L/<CR> open, h/H go up, q close
nnoremap <buffer> <silent> l :call helpers#netrw_open()<CR>
nnoremap <buffer> <silent> L :call helpers#netrw_open()<CR>
nnoremap <buffer> <silent> <CR> :call helpers#netrw_open()<CR>
nnoremap <buffer> <silent> h :call helpers#netrw_up()<CR>
nnoremap <buffer> <silent> H :call helpers#netrw_up()<CR>
" "-" is already netrw's own "go up one directory"
nnoremap <buffer> <silent> q :call helpers#netrw_close()<CR>
nnoremap <buffer> <silent> g? :help netrw<CR>

" Extra keys
nnoremap <buffer> <silent> <M-h> gh
nnoremap <buffer> <silent> <C-s> o
nnoremap <buffer> <silent> <C-v> v
nnoremap <buffer> <silent> <C-t> t

" Keep netrw's own C-h/C-l actions; the global mappings would make netrw's
" <unique> maps fail with E225.
nmap <buffer> <C-h> <Plug>NetrwHideEdit
nmap <buffer> <C-l> <Plug>NetrwRefresh
