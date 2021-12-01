call plug#begin()

" Completion, definitions, refactoring
source $HOME/.vim/plugins/coc.vim

" File manager / Comments
" -----------------------
source $HOME/.vim/plugins/nerd.vim
Plug 'tpope/vim-commentary'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_detect_iminsert = 1
let g:airline_theme='codedark'

" Start screen manager
" --------------------
Plug 'mhinz/vim-startify'

let g:startify_files_number = 5
let g:startify_change_to_dir = 0
let g:startify_custom_header = [ ]
let g:startify_relative_path = 1
let g:startify_use_env = 1

function! s:list_commits()
    let git = 'git -C ' . getcwd()
    let commits = systemlist(git . ' log --oneline | head -n5')
    let git = 'Git'
    return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

" Custom startup list, only show MRU from current directory/project
let g:startify_lists = [
\  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
\  { 'type': function('s:list_commits'), 'header': [ 'Recent Commits' ] },
\  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
\  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
\  { 'type': 'commands',  'header': [ 'Commands' ]       },
\ ]

let g:startify_commands = [
\   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
\   { 'cp': [ 'Clean Plugins', ':PlugClean' ] },
\   { 'ps': [ 'Plugins Status', ':PlugStatus' ] },
\ ]

" Python support
source $HOME/.vim/plugins/pymode.vim

Plug 'mbbill/undotree', { 'on': ['UndotreeToggle'] }
let g:undotree_WindowLayout = 3
nnoremap <leader>uu :UndotreeToggle<CR>

" File syntax
let g:polyglot_disabled = ['python.plugin']
Plug 'sheerun/vim-polyglot'

" Run tests
source $HOME/.vim/plugins/vim-test.vim

" Color themes
" ------------
Plug 'rakr/vim-one'
Plug 'NLKNguyen/papercolor-theme'
Plug 'dsolstad/vim-wombat256i'
Plug 'morhetz/gruvbox'
Plug 'tomasiser/vim-code-dark'

" Git Support
" -----------
source $HOME/.vim/plugins/fugitive.vim

Plug 'rhysd/git-messenger.vim', {'on': ['GitMessenger']}
nnoremap <leader>gm :GitMessenger<CR>

" Snippets
source $HOME/.vim/plugins/vsnip.vim

" Diagnostic
source $HOME/.vim/plugins/neomake.vim

" Toggle lists
Plug 'seandewar/vim-qftoggle'
nnoremap <leader>dl :Ltoggle<CR>
nnoremap <leader>dq :Ctoggle<CR>


" Other
" -----
Plug 'vim-scripts/LargeFile'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'kchmck/vim-coffee-script', { 'for': ['coffee'] }
Plug 'vim-scripts/ReplaceWithRegister'                  " Replace with register (gr)

call plug#end()
