" Test runner (vim-test)

scriptencoding utf-8

let g:test#strategy = 'terminal'
let g:test#python#runner = 'pytest'
let test#python#pytest#file_pattern = '\v(test[^/]+|[^/]+test)\.py$'

nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tt :TestSuite<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>
