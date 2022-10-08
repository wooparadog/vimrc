set tabstop=4 expandtab shiftwidth=4 softtabstop=4
set fdm=indent

:IndentGuidesEnable
let g:python_highlight_all = 0
let g:pyflakes_use_quickfix = 0
set foldmethod=indent

if exists("&colorcolumn")
    set colorcolumn=79
endif

let b:ale_linters = ['flake8', 'mypy']
let b:ale_fixers = ['black']
