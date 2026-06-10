" Run tests
Plug 'janko-m/vim-test', {'on': ['TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit']}

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>tt :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

let test#python#runner = 'pytest'
let g:test#python#pytest#file_pattern = '\v(test[^/]+|[^/]+test)\.py$'

