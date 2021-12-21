augroup vimrc
autocmd!

  " Only show cursorline in the current window and in normal mode.
  autocmd WinLeave,InsertEnter * set nocursorline
  autocmd WinEnter,InsertLeave * set cursorline

  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}

  " Restore cursor position
  autocmd BufWinEnter * call auto#restore_cursor()

  " Unset paste on InsertLeave
  autocmd InsertLeave * silent! set nopaste

  " Terminal
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal nonumber norelativenumber

augroup END


" Restore cursor position
fun! auto#restore_cursor() "{{{
    if line("'\"") <= line("$")
        normal! g`"
    endif
endfunction "}}}
