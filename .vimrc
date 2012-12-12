set t_Co=256
call pathogen#infect()

"===================================="
"           Basic Settings           "
"===================================="

syntax on
colorscheme blackbeauty ",koehler
filetype plugin on
filetype indent on


set autoindent
set backspace=eol,start,indent
set completeopt=menuone,preview
set cul cuc
set cursorline              " have a line indicate the cursor location
set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk
set fileencoding=utf-8
set fileformats=unix,dos
set history=1500
set hls is
set ignorecase
set incsearch               " Incrementally search while typing a /regex
set laststatus=2
set mouse =n
set nocp
set number
set scrolloff=3             " Keep 3 context lines above and below the cursor
set smartindent
set tabstop=4 expandtab shiftwidth=4 softtabstop=4 
set wildmenu

" Disabled Ones

" Y-N-C prompt if closing with unsaved changes.
"set confirm

"set list
"set listchars=tab:▸\ ,eol:¬

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
    elseif &filetype == 'markdown'
        exec "!markdown_py %>md_exported.html;google-chrome md_exported.html"
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
        exec "r !autopep8 -i % > /dev/null 2>&1"
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

"===================================="
"       Plugin Mapping Settings      "
"===================================="

map <leader>t :CtrlP<cr>
map <F2> :NERDTreeToggle <cr>
nnoremap <F5> :GundoToggle<CR>
nmap <silent> <F6> :TagbarToggle<CR>
let g:pep8_map='<leader>8'

"===================================="
"          Plugin Settings           "
"===================================="

let g:Powerline_symbols = 'fancy'

" Template =>
let g:templates_no_autocmd = 0
let g:template_dir = "~/.vim/templates/"
" <= Template

let MRU_Max_Entries = 100

let g:use_zen_complete_tag = 1
let g:user_zen_expandabbr_key = '<c-e>'

let g:pyflakes_use_quickfix = 0

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

"===================================="
"         Filetype Settings          "
"===================================="

" GO
set rtp+=~/go/go/misc/vim
autocmd BufRead,BufNewFile *.go set filetype=go

" Python
function! MakePython()
	execute "silent make %"
	execute "normal :"
	execute "copen"
endfunction

autocmd FileType python map <F4> :call MakePython()<CR>
autocmd FileType python set tabstop=4 expandtab shiftwidth=4 softtabstop=4
autocmd FileType python set makeprg=pylint\ --reports=n\ --output-format=parseable\ --disable=E1101,W0611,W0614,R0401,C0103,C0322,C0111,C0324,C0301,W0142,R0913,W0622,C0323\ %:p
autocmd FileType python set errorformat=%f:%l:\ %m
autocmd FileType python set smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class
autocmd FileType python :IndentGuidesEnable
autocmd FileType python let g:syntastic_python_checker_args = '--disable=E1101,W0611,W0614,R0401,C0103,C0322,C0111,C0324,C0301,W0142,R0913,W0622,C0323'
autocmd BufRead *.ptl set ft=python
" Highlighten Trailing Space 
autocmd FileType python highlight WhitespaceEOL ctermbg=red guibg=red
autocmd FileType python match WhitespaceEOL /\s\+$/

" Python Rope AutoComplete
let ropevim_vim_completion = 1
let ropevim_extended_complete = 1
let g:ropevim_autoimport_modules = ["os", "multiprocessing"]
let ropevim_enable_shortcuts = 1

if exists("&colorcolumn")
    autocmd FileType python set colorcolumn=79
endif

" Php
autocmd Filetype php set makeprg=\"php\"\ -l\ -n\ -d\ html_errors=off
autocmd Filetype php set errorformat=%m\ in\ %f\ on\ line\ %l
autocmd Filetype inc set ft=php

" C
autocmd Filetype c set tags+=/home/wooparadog/.vim/tags/tags

"===================================="
"       Douban Movie Settings        "
"===================================="

python << EOF
import vim
from  os import path
def GoToTemplate():
    import re
    strLine = vim.current.line
    templates = re.findall(r"'(.*?)'", strLine)
    templates.extend(re.findall(r'"(.*?)"', strLine)) 

    if templates:
        for template in templates:
            print template
            for p in ['movie/templates/', 'static']:
                filename = p+template
                print filename
                scss_filename = p + template[:-3] + 'scss'
                if path.exists(filename) :
                    vim.command("e %s" % filename) 
                    return
                if path.exists(scss_filename):
                    vim.command("e %s" % scss_filename) 
                    return
EOF
nnoremap <c-g> :py GoToTemplate()<CR>
