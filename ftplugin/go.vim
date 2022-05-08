let g:syntastic_go_checkers = ['govet', 'errcheck', 'golint']
let g:godef_split=0
let g:go_list_type = "quickfix"
let g:go_info_mode='gopls'
let g:go_def_mode='gopls'
let g:go_fmt_command = "goimports"
let g:go_metalinter_command = "golangci-lint"
let g:go_gocode_propose_builtins = 0

set noexpandtab tabstop=4
set fdm=syntax

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
