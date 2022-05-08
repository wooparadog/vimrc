"===================================="
"           Plugin Settings          "
"===================================="

source ~/.vim/plugins.vim

"===================================="
"           Basic Settings           "
"===================================="


" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"

if &diff
  colorscheme evening
else
  colorscheme koehler "blackbeauty, onedark, koehler
endif

filetype plugin on
filetype indent on

syntax on

set autoindent
set backspace=eol,start,indent
set completeopt=menuone,preview
set cul "cuc
set cursorline              " have a line indicate the cursor location
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gb2312,gbk
set fileformats=unix,dos
set history=1500
set hls is
set ignorecase
set incsearch               " Incrementally search while typing a /regex
set laststatus=2
set mouse =n
set nocp
set nofoldenable
set noshowmode
set nowrap
set number
set scrolloff=3             " Keep 3 context lines above and below the cursor
set shell=zsh
set showcmd
set smartindent
set undofile
set wildchar=<Tab> wildmenu wildmode=full

let g:email="guohaochuan@gmail.com"
let g:username="WooParadog"

" Buffers

set wildcharm=<C-Z>
nnoremap <F3> :b <C-Z>

nnoremap <Leader>1 :1b!<CR>
nnoremap <Leader>2 :2b!<CR>
nnoremap <Leader>3 :3b!<CR>
nnoremap <Leader>4 :4b!<CR>
nnoremap <Leader>5 :5b!<CR>
nnoremap <Leader>6 :6b!<CR>
nnoremap <Leader>7 :7b!<CR>
nnoremap <Leader>8 :8b!<CR>
nnoremap <Leader>9 :9b!<CR>
nnoremap <Leader>0 :10b!<CR>

set undodir=$HOME/.vim/undo
set wildignore+=*.pyc

"===================================="
"           Mapping Settings         "
"===================================="

" Quick jumping between splits
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

" Pull word under cursor into LHS of a substitute
nmap <leader>z :%s#\<<c-r>=expand("<cword>")<cr>\>#

" Pull Visually Highlighted text into LHS of a substitute
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Jump to next buffer
nmap <leader>n :bn<cr>
" Jump to previous buffer
nmap <leader>p :bp<cr>

" Enter visual line mode with <Space><Space>:
nmap <Leader><Leader> V

" terryma/vim-expand-region with following mapping:
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"===================================="
"         Advanced Settings          "
"===================================="

" Jump to last editing line
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Statusline =>
set laststatus=2                            " Always hide the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w  " Format the statusline
set lazyredraw                              " redraw only when we need to.

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction
" <= Statusline

" Really useful!
" In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left> 

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Run current file
map <F11> :call RunSrc()<CR>
func RunSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "!PYTHONPATH="." python %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'go'
        exec "!go build -o /tmp/go_built .;/tmp/go_built"
    elseif &filetype == 'ruby'
        exec "!ruby %"
    endif
    exec "e! %"
endfunc

" Auto format current file
map <F12> :call FormartSrc()<CR>
func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !yapf -i % > /dev/null 2>&1"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'modula2'
        exec "!landslide %"
    endif
    exec "e! %"
endfunc

" c-x c-x => git grep the word under cursor
let g:gitgrepprg="git\\ grep\\ -n"
let g:gitroot="`git rev-parse --show-cdup`"

function! GitGrep(args)
    let grepprg_bak=&grepprg
    exec "set grepprg=" . g:gitgrepprg
    execute 'silent! grep "\<' . a:args . '\>" ' . g:gitroot
    botright copen
    let &grepprg=grepprg_bak
    exec "redraw!"
endfunction

func GitGrepWord()
    normal! "zyiw
    call GitGrep(getreg('z'))
endf

nmap <C-x><C-x> :call GitGrepWord()<CR>
nmap <C-x><C-g> :Ack<cr>

"===================================="
"       Plugin Mapping Settings      "
"===================================="

map <F2> :NERDTreeToggle <cr>
nnoremap <F5> :GundoToggle<CR>
nmap <silent> <F6> :TagbarToggle<CR>
let g:pep8_map='<leader>8'

"===================================="
"          Plugin Settings           "
"===================================="

let g:syntastic_always_populate_loc_list = 1
let g:Powerline_symbols = 'fancy'
let g:pasteprg="pastbinit.py"
let g:shirevim#app="movie"
let g:pastemap="<c-b>"
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:startify_files_number = 20

let MRU_Max_Entries = 100

let g:use_zen_complete_tag = 1
let g:user_emmet_expandabbr_key = '<c-e>'

let g:pyflakes_use_quickfix = 0
let g:gist_show_privates = 1

let g:gist_show_privates = 1

"let g:tagbar_left = 1

" Tab =>
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 

let g:Tb_SplitToEdge = 1
let g:Tb_UseSingleClick = 1
let g:Tb_MaxSize = 5
" <= Tab

" Pydoc in normal mode, upper 'K' show pydoc =>
let g:pydiction_location = '~/.vim/ftplugin/python/complete-dict'
let g:pydoc_cmd = "pydoc" 
" <= Pydoc

let g:indent_guides_guide_size = 1
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|node_modules)$'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix' ]

"===================================="
"         Filetype Settings          "
"===================================="

" default tab
autocmd FileType python set tabstop=4 expandtab shiftwidth=4 softtabstop=4

" default tab
autocmd FileType json set tabstop=2 expandtab shiftwidth=2 softtabstop=2

" javascript
autocmd FileType javascript set tabstop=2 expandtab shiftwidth=2 softtabstop=2

" ruby
autocmd FileType ruby set tabstop=2 expandtab shiftwidth=2 softtabstop=2

" cmake
autocmd FileType cmake set tabstop=4 expandtab shiftwidth=4 softtabstop=4

" yaml
autocmd FileType yaml set tabstop=2 expandtab shiftwidth=2 softtabstop=2

" lua
autocmd FileType lua set tabstop=2 expandtab shiftwidth=2 softtabstop=2

" C++:
autocmd FileType cpp set tabstop=4 expandtab shiftwidth=4 softtabstop=4
autocmd FileType cpp nnoremap <buffer> <silent> gd :call g:ClangGotoDeclaration() <cr>
let g:syntastic_clang_check_config_file = ".clang_complete"
let g:syntastic_cpp_checkers = ["clang_check"]

if has('mac')
	let s:clang_library_path='./EosioClang-prefix/src/EosioClang-build/lib/'
	if isdirectory(s:clang_library_path)
		let g:clang_library_path=s:clang_library_path
	endif
elseif has('unix')
  autocmd FileType cpp set path+=/home/wooparadog/Codes/github.com/eosio/eos/contracts
  autocmd FileType cpp set path+=/usr/local/eosio.wasmsdk/include/
	let s:clang_library_path='/usr/lib/'
	if isdirectory(s:clang_library_path)
		let g:clang_library_path=s:clang_library_path
	endif
endif

let g:clang_complete_macros = 1
let g:clang_complete_patterns=1
let g:syntastic_clang_check_config_file = ".clang_complete"
let g:syntastic_cpp_checkers = ["clang_check"]

" Rust
let g:syntastic_rust_checkers = ['rustfmt']
if executable('rls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif 
let g:syntastic_rust_checkers = ['rustfmt']

" Golang
let g:syntastic_go_checkers = ['govet', 'errcheck', 'golint']
let g:godef_split=0
let g:go_list_type = "quickfix"
let g:go_info_mode='gopls'
let g:go_def_mode='gopls'
let g:go_fmt_command = "goimports"
let g:go_metalinter_command = "golangci-lint"
let g:go_gocode_propose_builtins = 0

autocmd BufRead,BufNewFile *.go set filetype=go
autocmd FileType go set noexpandtab tabstop=4
autocmd FileType go set fdm=syntax
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

" ptl
autocmd BufRead *.ptl set ft=python

" Python
let g:python_highlight_all = 1

autocmd FileType python set tabstop=4 expandtab shiftwidth=4 softtabstop=4
autocmd FileType python :IndentGuidesEnable
autocmd FileType python let g:syntastic_python_checker_args = '--ignore=E128'
autocmd FileType python nnoremap <buffer> <silent> gd :YcmCompleter GoToDeclaration <cr>

" Highlighten Trailing Space 
autocmd FileType python highlight WhitespaceEOL ctermbg=red guibg=red
autocmd FileType python match WhitespaceEOL /\s\+$/

" Python Rope AutoComplete
let ropevim_vim_completion = 1
let ropevim_extended_complete = 1
let g:ropevim_autoimport_modules = ["os", "multiprocessing"]
let ropevim_enable_shortcuts = 1
let ropevim_prefer_py3 = 1
let ropevim_goto_def_newwin = 1

if exists("&colorcolumn")
    autocmd FileType python set colorcolumn=79
endif

let g:syntastic_python_checkers = ['flake8']

" VIM
autocmd FileType vim set tabstop=2 expandtab shiftwidth=2 softtabstop=2

" Other formats
autocmd BufRead *.sls set ft=yaml
autocmd BufRead *.html set ft=mako
autocmd BufRead *.md set ft=markdown
autocmd FileType markdown set tabstop=4 expandtab shiftwidth=4 softtabstop=4
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
"let g:instant_markdown_python = 1

" Typescript
" let g:tsuquyomi_disable_quickfix = 1
autocmd FileType typescript set tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType typescriptreact set tabstop=2 expandtab shiftwidth=2 softtabstop=2
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.

" Javascript
autocmd FileType Javascript set tabstop=2 expandtab shiftwidth=2 softtabstop=2

" Php
autocmd Filetype php set makeprg=\"php\"\ -l\ -n\ -d\ html_errors=off
autocmd Filetype php set errorformat=%m\ in\ %f\ on\ line\ %l
autocmd Filetype inc set ft=php

" solidity
autocmd FileType solidity set tabstop=4 expandtab shiftwidth=4 softtabstop=4
let g:syntastic_solidity_checkers = ["solhint"]

" C
" git commit mesg
autocmd Filetype gitcommit set spell

hi Pmenu        guifg=#00ffff guibg=#000000            ctermbg=0 ctermfg=6
hi PmenuSel     guifg=#ffff00 guibg=#000000 gui=bold   cterm=bold ctermfg=3
hi PmenuSbar    guibg=#204d40                          ctermbg=6
hi PmenuThumb   guifg=#38ff56                          ctermfg=3

" quick fix
" autocmd FileType qf wincmd J
"

" lisp
autocmd BufRead *.el set ft=lisp
let g:gundo_prefer_python3=1

" airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline_powerline_fonts = 1


" Snip
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" nvim
lua <<EOF
  require'lspconfig'.pyright.setup{}
  require'lspconfig'.gopls.setup{}

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
  }
EOF
