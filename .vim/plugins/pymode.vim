Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Color max line
let g:pymode_options_max_line_length = 120

" Enable pymode indent
let g:pymode_indent = 0

" Enable pymode folding
let g:pymode_folding = 0

" Enable pymode motion
let g:pymode_motion = 0

" Enable pymode documentation helpers
let g:pymode_doc = 0

" Enable pymode detect virtualenv
let g:pymode_virtualenv = 1

" Enable pymode run code
let g:pymode_run = 1

" Enable pymode lint code
let g:pymode_lint = 0
let g:pymode_lint_unmodified = 1  " Check code on every save (every)

" Rope code completion
let g:pymode_rope = 0
