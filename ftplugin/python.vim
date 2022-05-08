set tabstop=4 expandtab shiftwidth=4 softtabstop=4

:IndentGuidesEnable
let g:syntastic_python_checker_args = '--ignore=E128'
let g:python_highlight_all = 1
let g:pyflakes_use_quickfix = 0

if exists("&colorcolumn")
    set colorcolumn=79
endif

let g:syntastic_python_checkers = ['flake8']
