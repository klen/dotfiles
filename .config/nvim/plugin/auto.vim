augroup vimrc
au!

  " Only show cursorline in the current window and in normal mode.
  au WinLeave,InsertEnter * set nocursorline
  au WinEnter,InsertLeave * set cursorline

  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}

  " Restore cursor position
  au BufWinEnter * call auto#restore_cursor()

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " Reload and compile plugins
  autocmd BufWritePost **/nvim/lua/plugin/*.lua source <afile> | PackerCompile

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
