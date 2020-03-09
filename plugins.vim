set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" Color schemes
Plugin 'flazz/vim-colorschemes'
Plugin 'dracula/vim'
Plugin 'AlessandroYorba/Sierra'
Plugin 'joshdick/onedark.vim'

" Plugin 'wooparadog/AutoComplPop'

Plugin 'tpope/vim-markdown'
Plugin 'vim-airline/vim-airline'
Plugin 'posva/vim-vue'
Plugin 'vim-python/python-syntax'
Plugin 'wooparadog/ropevim'
Plugin 'aperezdc/vim-template'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/gist-vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'othree/xml.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'suan/vim-instant-markdown'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/mru.vim'
Plugin 'vim-scripts/word_complete.vim'
Plugin 'Rip-Rip/clang_complete'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'mattn/emmet-vim'
Plugin 'menghan/CmdlineComplete'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'mattn/webapi-vim'
Plugin 'sjl/gundo.vim'
Plugin 'vim-scripts/The-NERD-tree'
Plugin 'jpythonfold.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-expand-region'
Plugin 'mmozuras/vim-github-comment'
Plugin 'fatih/vim-go'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tomlion/vim-solidity'
Plugin 'psliwka/vim-smoothie'

"Plugin 'phildawes/racer'
"Plugin 'prabirshrestha/async.vim'
"Plugin 'prabirshrestha/vim-lsp'
"Plugin 'prabirshrestha/asyncomplete.vim'
"Plugin 'prabirshrestha/asyncomplete-lsp.vim'


" Rust
Plugin 'rust-lang/rust.vim'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'

" {{{ snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
" Optional
Plugin 'honza/vim-snippets'
" }}}

" Plugin 'golang', {'rtp': 'bundle2/golang//'}

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
