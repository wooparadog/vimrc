set tabstop=4 expandtab shiftwidth=4 softtabstop=4
set fdm=indent

:IndentGuidesEnable
let g:python_highlight_all = 0
let g:pyflakes_use_quickfix = 0
set foldmethod=indent

if exists("&colorcolumn")
    set colorcolumn=79
endif

let b:ale_fix_on_save = 1
let b:ale_python_auto_virtualenv = 1
let b:ale_linters = ['black', 'mypy']
let b:ale_fixers = ['isort', 'black', 'autoflake']
let b:ale_python_autoflake_options = '--remove-all-unused-imports'
let b:ale_python_isort_options = '--profile black'
