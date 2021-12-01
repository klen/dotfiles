" File manager
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus'] }

" Key maps
nnoremap <silent> <leader>dd :NERDTreeFocus<CR>
nnoremap <silent> <leader>df :NERDTreeFind<CR>

" Options
let NERDTreeWinSize = 30
let NERDTreeMapOpenSplit = "<C-x>"
let NERDTreeMapOpenVSplit = "<C-v>"

" files/dirs to ignore in NERDTree (mostly the same as my svn ignores)
let NERDTreeIgnore=['\~$', '\.AppleDouble$', '\.beam$', 'build$',
\'dist$', '\.DS_Store$', '\.egg$', '\.egg-info$', '\.la$',
\'\.lo$', '\.\~lock.*#$', '\.mo$', '\.o$', '\.pt.cache$',
\'\.pyc$', '\.pyo$', '__pycache__$', '\.Python$', '\..*.rej$',
\'\.rej$', '\.ropeproject$', '\.svn$', '\.tags$' ]

augroup nerdtree
    autocmd!
    autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
    autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
augroup END

" let NERDTreeShowHidden=1
" let NERDTreeDirArrowExpandable = '▷'
" let NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  :'m',
    \ 'Staged'    :'s',
    \ 'Untracked' :'?',
    \ 'Renamed'   :'r',
    \ 'Unmerged'  :'u',
    \ 'Deleted'   :'d',
    \ 'Dirty'     :'~',
    \ 'Ignored'   :'i',
    \ 'Clean'     :'c',
    \ 'Unknown'   :'-',
\ }
