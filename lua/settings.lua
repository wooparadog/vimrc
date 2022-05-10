#! /usr/bin/env lua

vim.opt.termguicolors = true
vim.opt.autoindent    = true
vim.opt.backspace     = "eol,start,indent"
vim.opt.completeopt   = "menuone,preview"
vim.opt.cul           = true
vim.opt.cursorline    = true
vim.opt.encoding      = 'utf-8'
vim.opt.expandtab     = true
vim.opt.fileencoding  = 'utf-8'
vim.opt.fileencodings = 'utf-8,gb2312,gbk'
vim.opt.fileformats   = 'unix,dos'
vim.opt.foldenable    = false
vim.opt.history       = 1500
vim.opt.hlsearch      = true
vim.opt.ignorecase    = true
vim.opt.incsearch     = true
vim.opt.laststatus    = 3
vim.opt.mouse         = 'n'
vim.opt.number        = true
vim.opt.scrolloff     = 3
vim.opt.shell         = 'zsh'
vim.opt.shiftwidth    = 4
vim.opt.showcmd       = true
vim.opt.smartindent   = true
vim.opt.softtabstop   = 4
vim.opt.tabstop       = 4
vim.opt.undodir       = "undo"
vim.opt.undofile      = true
vim.opt.wrap          = false

vim.opt.listchars:append("eol:↴")
vim.opt.wildignore:append("*.pyc")
