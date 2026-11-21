" Autocommands

scriptencoding utf-8

augroup config
    autocmd!

    " Highlight yanked text
    autocmd TextYankPost * silent! call helpers#highlight_yank()

    " Restore the last cursor position when reopening a file
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line('$')
                \ | execute 'normal! g`"'
                \ | endif

    " Terminal buffers: insert mode, no line numbers
    autocmd TerminalOpen * startinsert | setlocal nonumber norelativenumber

    " Special buffers are unlisted; q closes them
    autocmd FileType help,qf,checkhealth setlocal nobuflisted
    autocmd FileType help,qf,checkhealth nnoremap <buffer> <silent> q :close<CR>

    " Cursorline only in the active window and in normal mode
    autocmd WinLeave,InsertEnter * set nocursorline
    autocmd WinEnter,InsertLeave * set cursorline

    " Large files: no syntax/LSP. Detection and 'syntax on' run after BufReadPre,
    " so the flag is set there and applied once the buffer is read.
    autocmd BufReadPre *
                \ if getfsize(expand('<afile>')) > 5 * 1024 * 1024
                \ | let b:large_file = 1
                \ | endif
    autocmd BufReadPost *
                \ if get(b:, 'large_file', 0)
                \ | setlocal syntax=off filetype= foldmethod=manual
                \ | endif

    " Cache the git branch for the statusline (FugitiveHead() is not free)
    autocmd BufEnter * if exists('g:loaded_fugitive') | let b:gitbranch = FugitiveHead() | endif
augroup END
