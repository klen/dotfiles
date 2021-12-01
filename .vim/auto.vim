" Autocommands

if has("autocmd")

    augroup vimrc
    au!

        " Auto reload vim settins
        au BufWritePost ~/.vim/*.vim source $MYVIMRC

        " Only show cursorline in the current window and in normal mode.
        au WinLeave,InsertEnter * set nocursorline
        au WinEnter,InsertLeave * set cursorline

        au BufRead * :set cpoptions+=J

        " Autosave last session
        if has('mksession')
            au VimLeavePre * exe "mks! " g:SESSION_DIR.'/last.vim'
        endif

        " Unset paste on InsertLeave
        au InsertLeave * silent! set nopaste

    augroup END

endif
