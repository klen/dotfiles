" ================================
" .vimrc klen <horneds@gmail.com>
" ================================

scriptencoding utf-8

" Options
source $HOME/.vim/opts.vim

" Open help in a vsplit rather than a split
command! -nargs=? -complete=help Help :vertical help <args>
cabbrev h h<C-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<CR>

" Enable extended matchit
runtime macros/matchit.vim

" Auto commands
source $HOME/.vim/auto.vim

" Key maps
source $HOME/.vim/maps.vim

" Plugins
source $HOME/.vim/plugins/init.vim

" Color theme
if !exists('g:colors_name')
    colorscheme codedark
    set background=dark
endif

" enables the reading of .vimrc, .exrc and .gvimrc in the current directory.
set exrc

" must be written at the last.  see :help 'secure'.
set secure
