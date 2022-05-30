call plug#begin()

" Beauty
" Plug 'vim-airline/vim-airline'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
"Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'feline-nvim/feline.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'smiteshp/nvim-gps'

" Color schemes
Plug 'flazz/vim-colorschemes'
Plug 'dracula/vim'
Plug 'AlessandroYorba/Sierra'
Plug 'joshdick/onedark.vim'

" Autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'rafamadriz/friendly-snippets'

" File management
Plug 'kien/ctrlp.vim'
Plug 'kyazdani42/nvim-tree.lua'

" Git
Plug 'airblade/vim-gitgutter' " A Vim plugin which shows a git diff in the sign column. It shows which lines have been added, modified, or removed. You can also preview, stage, and undo individual hunks; and stage partial hunks. The plugin also provides a hunk text object.
Plug 'tpope/vim-fugitive' " Git integration
Plug 'mattn/gist-vim'
Plug 'codeindulgence/vim-tig'
Plug 'lewis6991/gitsigns.nvim'

" Text handling
Plug 'junegunn/vim-easy-align'
Plug 'prettier/vim-prettier'

" Filetypes
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Misc
Plug 'aperezdc/vim-template'
Plug 'jlanzarotta/bufexplorer'
Plug 'jmcantrell/vim-virtualenv'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mattn/webapi-vim'
Plug 'mileszs/ack.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'othree/xml.vim'
Plug 'psliwka/vim-smoothie'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'vim-python/python-syntax'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/mru.vim'
Plug 'tpope/vim-eunuch'
Plug 'mhinz/vim-startify'


call plug#end()
