set confirm                           " Prompt to save unsaved changes when exiting
set backup                            " Make backup file and leave it around
set backupdir=/tmp/nvim/backup        " Where to put backup files
set directory=/tmp/nvim/swap          " Where to put swap files
let g:SESSION_DIR='/tmp/nvim/session' " where to keep sessions

" Create directories
if finddir(&directory) == ''
    silent call mkdir(&directory, "p")
endif

if finddir(g:SESSION_DIR) == ''
    silent call mkdir(g:SESSION_DIR, "p")
endif

set title                           " Show file name in window title
set clipboard+=unnamedplus
set cursorline                      " Enable Cursor line
set linebreak                       " Break lines by words
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:$,nbsp:~
set fillchars=fold:·
set winminheight=0                  " Min window height
set winminwidth=0                   " Min window width
set scrolloff=4                     " Min 4 symbols bellow cursor
set sidescroll=4
set sidescrolloff=10
set whichwrap=b,s,<,>,[,],l,h
" set completeopt=menu,longest
set completeopt=menu,menuone,noselect
set ruler                           " Show the line and column number of the cursor position

" Number line settings.
set number                          " Enable number line
set numberwidth=2
set signcolumn=number               " Place signs in number line

" Set indentation stuf
set smartindent                     " Enable nice indent
set shiftwidth=2                    " Number of spaces to use for each step of indent
set expandtab                       " Tab with spaces
set softtabstop=2                   " Tab like 2 spaces
set shiftround                      " Drop unused spaces

" Set searching stuf
set ignorecase                      " Ignore case in search patterns
set infercase                       " Enable case-sensetive search for non lower-case string
set smartcase                       " Override the 'ignorecase' option if the search pattern contains upper case characters
set path=**

" Insert mode
set virtualedit=all                 " Allow virtualedit for all modes
set nrformats=                      " Dont use octal and hex in number operations

" Matching characters
set showmatch                       " Show matching brackets
set matchpairs+=<:>         	    " Make < and > match as well

" Localization
set keymap=russian-jcukenwin        " Alternative keymap
set encoding=utf-8                  " Default encoding
set fileencodings=utf-8
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
set iminsert=0                      " English by default

" Persistent undo
set undofile

" Folding
set foldlevel=999                   " High default so folds are shown to start
set foldlevelstart=999              " High default so folds are shown to start

" True collor support.
set termguicolors

" Setting colorcolumn. This is set because of
" this (https://github.com/lukas-reineke/indent-blankline.nvim/issues/59)
" indent-blankline bug.
set colorcolumn=9999

" Set terminal bidirectual.
" For writing in right to left languages like arabic, persian and hebrew.
set termbidi

" For opening splits on right or bottom.
set splitbelow
set splitright

" Setting time that Neovim wait after each keystroke.
set ttimeoutlen=500
set timeoutlen=500

" Disable nvim intro
set shortmess+="sI"

" Enables the reading of .vimrc, .exrc and .gvimrc in the current directory.
set exrc
