set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Color schemes
Plugin 'flazz/vim-colorschemes'
Plugin 'dracula/vim'
Plugin 'AlessandroYorba/Sierra'
Plugin 'joshdick/onedark.vim'

" Autocomplete
Plugin 'neovim/nvim-lspconfig'
Plugin 'hrsh7th/cmp-nvim-lsp'
Plugin 'hrsh7th/cmp-buffer'
Plugin 'hrsh7th/cmp-path'
Plugin 'hrsh7th/cmp-cmdline'
Plugin 'hrsh7th/nvim-cmp'
Plugin 'hrsh7th/cmp-vsnip'
Plugin 'hrsh7th/vim-vsnip'
Plugin 'rafamadriz/friendly-snippets'

" Misc
Plugin 'airblade/vim-gitgutter' " A Vim plugin which shows a git diff in the sign column. It shows which lines have been added, modified, or removed. You can also preview, stage, and undo individual hunks; and stage partial hunks. The plugin also provides a hunk text object.
Plugin 'aperezdc/vim-template'
Plugin 'fatih/vim-go'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'jpythonfold.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'menghan/CmdlineComplete'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mileszs/ack.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'othree/xml.vim'
Plugin 'posva/vim-vue'
Plugin 'psliwka/vim-smoothie'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'instant-markdown/vim-instant-markdown'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-fugitive' " Git integration
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-python/python-syntax'
Plugin 'vim-scripts/The-NERD-tree'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/mru.vim'
Plugin 'vim-scripts/word_complete.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'mhinz/vim-startify'

call vundle#end()
