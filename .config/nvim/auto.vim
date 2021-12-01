augroup vimrc
au!

  " Only show cursorline in the current window and in normal mode.
  au WinLeave,InsertEnter * set nocursorline
  au WinEnter,InsertLeave * set cursorline

  " Restore cursor position
  au BufWinEnter * call auto#restore_cursor()

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " Reload and compile plugins
  autocmd BufWritePost ~/.config/nvim/lua/plugins/*.lua source <afile> | PackerCompile
  autocmd BufWritePost ~/.config/nvim/lua/configs/*.lua source <afile> | PackerCompile

  " Terminal
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal nonumber norelativenumber

augroup END


" Restore cursor position
fun! auto#restore_cursor() "{{{
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction "}}}
