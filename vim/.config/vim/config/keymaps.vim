" Key maps

scriptencoding utf-8

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" General
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

" Reload config (Vim has no :restart)
nnoremap <silent> <leader>dr :source $MYVIMRC<CR>

" Clear search, diff update and redraw
nnoremap <silent> <C-c> :nohlsearch<CR>:diffupdate<CR>:redraw!<CR>

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Save / Quit
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

nnoremap <silent> <CR> :call helpers#save()<CR>
nnoremap <silent> <S-CR> :call helpers#fast_save()<CR>
nnoremap <silent> <leader>qq :qa<CR>

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Navigation
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <expr> k v:count == 0 ? 'gk' : 'k'

nnoremap <silent> <C-d> <C-d>zz
nnoremap <silent> <C-u> <C-u>zz

" tmux and split navigation
nnoremap <silent> <C-h> :call helpers#move('h')<CR>
nnoremap <silent> <C-j> :call helpers#move('j')<CR>
nnoremap <silent> <C-k> :call helpers#move('k')<CR>
nnoremap <silent> <C-l> :call helpers#move('l')<CR>

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Search
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

nnoremap <silent> * *N
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Copy
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

nnoremap <silent> <leader>cc :call helpers#copy_location()<CR>
xnoremap <silent> <leader>cc :call helpers#copy_location_range()<CR>

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Editing
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

nnoremap <silent> x "_x
vnoremap <silent> p "_dP
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" Comments (native, no plugin)
nnoremap <silent> gcc :call helpers#toggle_comment()<CR>
xnoremap <silent> gc :call helpers#toggle_comment()<CR>
" gc{motion}, e.g. gcap — needs opfunc because Vim has no built-in gc operator
nnoremap <silent> gc :<C-U>set opfunc=helpers#comment_op<CR>g@

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Windows
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

nnoremap <silent> <C-w>cc :close<CR>
nnoremap <silent> <C-w>ck :wincmd k<CR>:close<CR>
nnoremap <silent> <C-w>cj :wincmd j<CR>:close<CR>
nnoremap <silent> <C-w>ch :wincmd h<CR>:close<CR>
nnoremap <silent> <C-w>cl :wincmd l<CR>:close<CR>

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Buffers / File browser
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

nnoremap <silent> <leader>bd :bdelete<CR>
nnoremap <silent> <leader>br :edit!<CR>

nnoremap <silent> <leader>ff :call helpers#fern_open(1)<CR>
nnoremap <silent> <leader>fe :call helpers#fern_open(0)<CR>

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Diff
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

nnoremap <silent> <leader>dt :diffthis<CR>
nnoremap <silent> <leader>dp :diffput<CR>
nnoremap <silent> <leader>dg :diffget<CR>

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Terminal
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

tnoremap <silent> <C-[> <C-\><C-n>
tnoremap <silent> <C-h> <Cmd>call helpers#move('h')<CR>
tnoremap <silent> <C-j> <Cmd>call helpers#move('j')<CR>
tnoremap <silent> <C-k> <Cmd>call helpers#move('k')<CR>
tnoremap <silent> <C-l> <Cmd>call helpers#move('l')<CR>

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Completion / Copilot
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

" <C-@> and <C-Space> are the same key code in a terminal, so one mapping is enough
inoremap <silent> <C-Space> <C-\><C-o>:call lsp#completion#LspComplete(v:true)<CR>
inoremap <silent><expr> <C-y> helpers#accept()

" Undo states (no plugin): pick a state, or step with g- / g+
nnoremap <silent> <leader>u :call helpers#undo_menu()<CR>

" Key hints on demand: native listing, no mapping on <leader> itself
" (a mapping there delays every leader command).
nnoremap <silent> <leader>? :<C-U>map <Leader><Bar>map <buffer><CR>

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Toggles
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

nnoremap <silent> <leader>ow :set wrap!<CR>
nnoremap <silent> <leader>ol :set list!<CR>
nnoremap <silent> <leader>on :set number!<CR>
nnoremap <silent> <leader>or :set relativenumber!<CR>
nnoremap <silent> <leader>os :set spell!<CR>
nnoremap <silent> <leader>of :set foldenable!<CR>
nnoremap <expr> <leader>oc &conceallevel ? ':set conceallevel=0<CR>' : ':set conceallevel=2<CR>'
nnoremap <expr> <leader>ob &background ==# 'dark' ? ':set background=light<CR>' : ':set background=dark<CR>'
