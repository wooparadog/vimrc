"===================================="
"           Plugin Settings          "
"===================================="

source ~/.vim/plugins.vim

"===================================="
"           Lua Init                 "
"===================================="

source ~/.vim/vimrc.lua

"===================================="
"           Basic Settings           "
"===================================="

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

let g:pydoc_cmd = "pydoc"

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

hi Pmenu        guifg=#00ffff guibg=#000000            ctermbg=0 ctermfg=6
hi PmenuSel     guifg=#ffff00 guibg=#000000 gui=bold   cterm=bold ctermfg=3
hi PmenuSbar    guibg=#204d40                          ctermbg=6
hi PmenuThumb   guifg=#38ff56                          ctermfg=3

set undodir=$HOME/.vim/undo
set wildignore+=*.pyc

" Highlighten Trailing Space
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * startinsert

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

map <F2> :NERDTreeToggle<CR>
map <F5> :GundoToggle<CR>
map <F6> :TagbarToggle<CR>
nnoremap <F7> :call terminal#toggle()<CR>
tnoremap <F7> <C-\><C-n>:call terminal#toggle()<cr>

"===================================="
"          Plugin Settings           "
"===================================="

let g:syntastic_always_populate_loc_list = 1
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:startify_files_number = 20
let g:templates_directory = ["~/.vim/templates/"]
let MRU_Max_Entries = 100
let g:user_emmet_expandabbr_key = '<c-e>'
let g:gist_show_privates = 1
let g:indent_guides_guide_size = 1

let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|node_modules)$'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix' ]

let g:gundo_prefer_python3=1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1

" Tig
let g:tig_default_command = ''

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

" LSP
nnoremap gd :lua vim.lsp.buf.definition()<CR>
