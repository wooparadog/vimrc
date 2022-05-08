set tabstop=4 expandtab shiftwidth=4 softtabstop=4
nnoremap <buffer> <silent> gd :call g:ClangGotoDeclaration() <cr>

let g:syntastic_clang_check_config_file = ".clang_complete"
let g:syntastic_cpp_checkers = ["clang_check"]
let g:clang_complete_macros = 1
let g:clang_complete_patterns=1
