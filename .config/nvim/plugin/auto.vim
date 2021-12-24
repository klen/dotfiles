if has("autocmd")

  augroup vimrc
  autocmd!

    " Only show cursorline in the current window and in normal mode.
    autocmd WinLeave,InsertEnter * set nocursorline
    autocmd WinEnter,InsertLeave * set cursorline

    autocmd BufRead .vimrc.lua set ft=lua

    " Unset paste on InsertLeave
    autocmd InsertLeave * silent! set nopaste

    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}

    " Restore cursor position
    autocmd BufWinEnter * call auto#restore_cursor()

    " Terminal
    autocmd TermOpen * startinsert
    autocmd TermOpen * setlocal nonumber norelativenumber

  augroup END

endif


" Restore cursor position
fun! auto#restore_cursor() "{{{
    if line("'\"") <= line("$")
        normal! g`"
    endif
endfunction "}}}
