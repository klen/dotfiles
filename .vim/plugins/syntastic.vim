Plug 'vim-syntastic/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
" let g:syntastic_id_checkers = 1
let g:syntastic_error_symbol = "EE"
let g:syntastic_warning_symbol = "WW"
let g:syntastic_style_error_symbol = "SE"
let g:syntastic_style_warning_symbol = "SW"
let g:syntastic_stl_format = "[%E{EE %fe #%e}%B{, }%W{WW: %fw #%w}]"


let g:syntastic_python_checkers = ['pylama', 'mypy']
let g:syntastic_javascript_checkers = ['eslint']
