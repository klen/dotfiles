" ================================
" .vimrc klen <horneds@gmail.com>
" ================================

scriptencoding utf-8

" Open help in a vsplit rather than a split
command! -nargs=? -complete=help Help :vertical help <args>
cabbrev h h<C-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<CR>

" Enable extended matchit
runtime macros/matchit.vim

" Key maps
source $HOME/.vim/keymaps.vim

" Plugins
source $HOME/.vim/plugins/init.vim

" Color theme
if !exists('g:colors_name')
    set background=dark
    try
        colorscheme codedark
    catch /.*/
        colorscheme default
    endtry
endif

" must be written at the last.  see :help 'secure'.
set secure
