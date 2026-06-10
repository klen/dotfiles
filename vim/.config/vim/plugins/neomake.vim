Plug 'neomake/neomake'

" autocmd VimEnter * call neomake#configure#automake('w')


let g:neomake_python_enabled_makers = ['pylama', 'mypy']
let g:neomake_open_list = 1

let g:neomake_error_sign = { 'text': 'EE', 'texthl': 'NeomakeErrorSign' }
let g:neomake_warning_sign = { 'text': 'WW', 'texthl': 'NeomakeWarningSign' }
let g:neomake_message_sign = { 'text': 'MM', 'texthl': 'NeomakeMessageSign' }
let g:neomake_info_sign = { 'text': 'HH', 'texthl': 'NeomakeInfoSign' }

let g:neomake_highlight_columns = 0
