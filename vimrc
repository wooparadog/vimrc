"===================================="
"           Lua Init                 "
"===================================="

" lua/init.lua bootstraps lazy.nvim, then loads options, plugins, keymaps.
source ~/.vim/lua/init.lua

"===================================="
"           Basic Settings           "
"===================================="

colorscheme evening

filetype plugin on
filetype indent on

syntax on

" Highlighten Trailing Space
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
highlight Normal guibg=NONE

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
endfunc

" c-x c-x => git grep the word under cursor
function! GitGrep(args)
    execute 'silent Ggrep!' . ' "\<' . a:args . '\>"' | cw | redraw!
endfunction

func GitGrepWord()
    normal! "zyiw
    call GitGrep(getreg('z'))
endf

"===================================="
"       LSP Commands                 "
"===================================="

command LspDeclaration             lua vim.lsp.buf.declaration()
command LspDefinition              lua vim.lsp.buf.definition()
command LspHover                   lua vim.lsp.buf.hover()
command LspImplementation          lua vim.lsp.buf.implementation()
command LspSignatureHelp           lua vim.lsp.buf.signature_help()
command LspAddWorkspaceFolder      lua vim.lsp.buf.add_workspace_folder()
command LspRemoveWorkspaceFolder   lua vim.lsp.buf.remove_workspace_folder()
command LspTypeDefinition          lua vim.lsp.buf.type_definition()
command LspRename                  lua vim.lsp.buf.rename()
command LspCodeAction              lua vim.lsp.buf.code_action()
command LspReferences              lua vim.lsp.buf.references()
command LspFormatting              lua vim.lsp.buf.formatting()

" Plugin-specific globals are now set inside each plugin's spec
" under lua/plugins/ via the `init = function() ... end` hook.
