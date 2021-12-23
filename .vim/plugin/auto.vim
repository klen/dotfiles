" Autocommands

if has("autocmd")

    augroup vimrc
    autocmd!

        " Only show cursorline in the current window and in normal mode.
        autocmd WinLeave,InsertEnter * set nocursorline
        autocmd WinEnter,InsertLeave * set cursorline

        " Unset paste on InsertLeave
        autocmd InsertLeave * silent! set nopaste

        " Auto reload vim settins
        autocmd BufWritePost ~/.vim/*.vim source $MYVIMRC

        " Autosave last session
        if has('mksession')
            autocmd VimLeavePre * exe "mksession! " g:SESSION_DIR.'/last.vim'
        endif

    augroup END

endif
