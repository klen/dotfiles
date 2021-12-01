" Completion, definitions, refactoring
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

" Key Maps
" --------

" Show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Navigate through code
nmap <silent> gr <plug>(coc-references)
nmap <silent> gd <plug>(coc-definition)
nmap <silent> <space>gd :sp<cr><plug>(coc-definition)
nmap <silent> gt <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)

" Navigate through errors
nmap <silent> ge <plug>(coc-diagnostic-info)
nmap <silent> [d <plug>(coc-diagnostic-prev)
nmap <silent> ]d <plug>(coc-diagnostic-next)

 " Rename objects
nmap <space>r <plug>(coc-rename)
nmap <leader>rf <plug>(coc-refactor)
nmap <leader>rx <plug>(coc-fix-current)

" Run Coc actions
nmap <space>a <plug>(coc-codeaction)
xmap <leader>a <plug>(coc-codeaction-selected)

" Formatting
nmap <space>f <plug>(coc-format)

"Scroll over hover windows
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<Enter>" : "\<Right>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<Enter>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"

" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" Select functions
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" Select classes
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Toggle Outline
nmap <leader>lc :CocOutline<CR>

" File/Buffers search
nnoremap <silent> <Leader>cl :CocList buffers<CR>
nnoremap <silent> <Leader>ff :CocList files<CR>

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> gw :exe 'CocList -I --no-quit --input='.expand('<cword>').' grep'<CR>

" Commands
" --------

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')


" Config
" ------

let g:coc_global_extensions = [ 'coc-css', 'coc-eslint', 'coc-json' ]

let g:coc_global_extensions += ['coc-lists']            " Basic list sources (buffers, files)
let g:coc_global_extensions += ['coc-marketplace']      " Coc extensions marketplace
let g:coc_global_extensions += ['coc-pairs']            " Auto pair extension
let g:coc_global_extensions += ['coc-prettier']         " prettier extension
let g:coc_global_extensions += ['coc-pyright']          " Pyright extension, static type checker for Python
let g:coc_global_extensions += ['coc-rust-analyzer']    " rust-analyzer for Vim/Neovim
let g:coc_global_extensions += ['coc-tsserver']         " tsserver extension
let g:coc_global_extensions += ['coc-vimlsp']           " vim language server extension
let g:coc_global_extensions += ['coc-lua']

" Autocommands
" ------------

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Functions
" ---------

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" " Snippets
" " --------

" let g:coc_global_extensions += ['coc-snippets']         " Snippets extension
" Plug 'honza/vim-snippets'

" " " Use tab for trigger completion with characters ahead and navigate.
" " " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " " other plugin before putting this into your config.
" " inoremap <silent><expr> <TAB>
" "       \ pumvisible() ? coc#_select_confirm() :
" "       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
" "       \ <SID>check_back_space() ? "\<TAB>" :
" "       \ coc#refresh()
