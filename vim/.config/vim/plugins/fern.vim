" Fern file manager

let g:fern#drawer_width = 30
let g:fern#disable_drawer_hover_popup = 1

function! s:init_fern() abort
    " Extra keys
    nmap <buffer><silent> <M-h> <Plug>(fern-action-hidden)
    nmap <buffer><silent> <C-s> <Plug>(fern-action-open:split)
    nmap <buffer><silent> <C-v> <Plug>(fern-action-open:vsplit)
    nmap <buffer><silent> <C-t> <Plug>(fern-action-open:tabedit)
    nmap <buffer><silent> g? <Plug>(fern-action-help)
    nnoremap <buffer><silent> q :close<CR>
endfunction

augroup fern
    autocmd!
    autocmd FileType fern call s:init_fern()
augroup END
