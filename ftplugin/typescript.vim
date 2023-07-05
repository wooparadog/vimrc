" let g:tsuquyomi_disable_quickfix = 1
set tabstop=4 expandtab shiftwidth=4 softtabstop=4
"let g:syntastic_typescript_checkers = ['eslint'] " You shouldn't use 'tsc' checker.
"let g:syntastic_typescriptreact_checkers = ['eslint'] " You shouldn't use 'tsc' checker.
:IndentGuidesEnable

let b:ale_linters = ['eslint', 'tsserver']
let b:ale_fixers = ['eslint']
let b:ale_fix_on_save = 1
