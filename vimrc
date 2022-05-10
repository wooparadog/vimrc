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

colorscheme evening

filetype plugin on
filetype indent on

syntax on

let g:email="guohaochuan@gmail.com"
let g:username="WooParadog"

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

" Enter visual line mode with <Space><Space>:
nmap <Leader><Leader> V

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
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        exe "menu Foo.Bar :" . "vimgrep " . '/'. l:pattern . '/' . ' **/*.'
        emenu Foo.Bar
        unmenu Foo
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Run current file
func RunSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py' || &filetype == 'python'
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
function! GitGrep(args)
    let grepprg_bak=&grepprg
    exec "set grepprg=" . "git\\ grep\\ -n"
    execute 'silent! grep "\<' . a:args . '\>" ' . "`git rev-parse --show-cdup`"
    botright copen
    let &grepprg=grepprg_bak
    exec "redraw!"
endfunction

func GitGrepWord()
    normal! "zyiw
    call GitGrep(getreg('z'))
endf

vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>

nmap <C-x><C-x> :call GitGrepWord()<CR>
nmap <C-x><C-g> :Ack<cr>

map <F11> :call RunSrc()<CR>
map <F12> :call FormartSrc()<CR>

"===================================="
"       Plugin Mapping Settings      "
"===================================="

nnoremap <F2> :NvimTreeToggle<CR>
nnoremap <F5> :GundoToggle<CR>
nnoremap <F6> :TagbarToggle<CR>
nnoremap <F7> :call terminal#toggle()<CR>
tnoremap <F7> <C-\><C-n>:call terminal#toggle()<cr>

nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

nnoremap <leader>n :BufferLineCycleNext<CR>
nnoremap <leader>p :BufferLineCyclePrev<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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
