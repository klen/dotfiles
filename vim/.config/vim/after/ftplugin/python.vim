setlocal colorcolumn=100

nnoremap <buffer> <silent> <leader>db :call helpers#toggle_breakpoint()<CR>

" Global commands, defined once
if !exists(':RuffQF')
    command! RuffQF call helpers#qf_from_cmd('Ruff', 'uv run ruff check --output-format=concise', '%f:%l:%c: %m')
    command! PyreflyQF call helpers#qf_from_cmd('Pyrefly', 'uv run pyrefly check --output-format min-text', '%t%*[A-Z ] %f:%l:%c-%*[^:]: %m')
    command! MypyQF call helpers#qf_from_cmd('Mypy', 'uv run mypy --hide-error-context --show-column-numbers --no-color-output', '%f:%l:%c: %t%*[^:]: %m')
endif
