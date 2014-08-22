set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'git://github.com/Lokaltog/vim-powerline.git'
Plugin 'git://github.com/aperezdc/vim-template.git'
Plugin 'git://github.com/kien/ctrlp.vim.git'
Plugin 'git://github.com/majutsushi/tagbar.git'
Plugin 'git://github.com/mattn/gist-vim.git'
Plugin 'git://github.com/msanders/snipmate.vim.git'
Plugin 'git://github.com/nathanaelkane/vim-indent-guides.git'
Plugin 'git://github.com/othree/xml.vim.git'
Plugin 'git://github.com/scrooloose/nerdcommenter.git'
Plugin 'git://github.com/scrooloose/syntastic.git'
Plugin 'git://github.com/suan/vim-instant-markdown.git'
Plugin 'git://github.com/tpope/vim-surround.git'
Plugin 'git://github.com/vim-scripts/TabBar.git'
Plugin 'git://github.com/vim-scripts/matchit.zip.git'
Plugin 'git://github.com/vim-scripts/mru.vim.git'
Plugin 'git://github.com/vim-scripts/word_complete.vim.git'
Plugin 'git@github.com:Rip-Rip/clang_complete.git'
Plugin 'git@github.com:dgryski/vim-godef.git'
Plugin 'git@github.com:jmcantrell/vim-virtualenv.git'
Plugin 'git@github.com:mattn/emmet-vim.git'
Plugin 'git@github.com:menghan/CmdlineComplete.git'
Plugin 'git@github.com:mileszs/ack.vim.git'
Plugin 'git@github.com:tpope/vim-fugitive.git'
Plugin 'git@github.com:tpope/vim-rails.git'
Plugin 'git@github.com:vim-ruby/vim-ruby.git'
Plugin 'https://github.com/mattn/webapi-vim.git'
Plugin 'https://github.com/sjl/gundo.vim.git'
Plugin 'https://github.com/vim-scripts/The-NERD-tree.git'
Plugin 'https://github.com/vim-scripts/pep8.git'
Bundle 'Blackrush/vim-gocode'
Plugin 'wting/rust.vim'

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
