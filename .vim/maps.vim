" Map keys
let mapleader = ","
let maplocalleader = " "

" Navigation
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap gI `.
nnoremap <left>  :cprev<cr>zvzz
nnoremap <right> :cnext<cr>zvzz
nnoremap <up>    :lprev<cr>zvzz
nnoremap <down>  :lnext<cr>zvzz

" Automatically jump to end of text you pasted
nnoremap <silent> p p`]
vnoremap <silent> p p`]

" Not jump on star, only highlight
nnoremap * *N

" turn off search highlighting
nnoremap <leader><space> :noh<CR>

" Save file
noremap <silent> <CR> :w<CR>

" Toggle keymap
inoremap <silent> <C-F> <C-^>
nnoremap <silent> <C-F> a<C-^><Esc>
vnoremap <silent> <C-F> <Esc>a<C-^><Esc>gv

" Command mode
cnoremap        <C-A> <Home>
cnoremap        <C-E> <End>

" Paste relaces visual selection do not copy it
vnoremap p "_dP

" Commands
command! -nargs=0 Reset   write | :edit
command! -nargs=0 Remove  call delete(expand('%')) | bdelete

" File operations
nnoremap <leader>fn <cmd>enew<CR>
nnoremap <leader>dq <cmd>copen<CR>
nnoremap <leader>dl <cmd>lopen<CR>

" Window commands
nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <silent> <leader>j :wincmd j<CR>
nnoremap <silent> <leader>k :wincmd k<CR>
nnoremap <silent> <leader>l :wincmd l<CR>
nnoremap <silent> <leader>cj :wincmd j<CR>:close<CR>
nnoremap <silent> <leader>ck :wincmd k<CR>:close<CR>
nnoremap <silent> <leader>ch :wincmd h<CR>:close<CR>
nnoremap <silent> <leader>cl :wincmd l<CR>:close<CR>
nnoremap <silent> <leader>cc :close<CR>

" Buffer commands
noremap <silent> <leader>bd :bd<CR>
noremap <silent> <leader>bn :bn<CR>
noremap <silent> <leader>bp :bp<CR>
noremap <silent> <Tab> :bn<CR>
noremap <silent> <S-Tab> :bp<CR>

" Plugins
noremap <silent> <leader>ps :PlugStatus<CR>
noremap <silent> <leader>pu :PlugUpdate<CR>
noremap <silent> <leader>pc :PlugClean<CR>
noremap <silent> <leader>pi :PlugInstall<CR>

" Options
nnoremap <silent> <leader>op :set paste! paste?<CR>
nnoremap <silent> <leader>ol :set list! list?<CR>
nnoremap <silent> <leader>ow :set wrap! wrap?<CR>
nnoremap <silent> <leader>on :call helpers#ToggleRelativeAbsoluteNumber()<CR>

" Other
nnoremap gw :call helpers#vimgrep()<CR>

" Show syntax highlighting groups for word under cursor
nnoremap gm :call helpers#synstac()<CR>

