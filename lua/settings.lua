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
vim.opt.undofile      = true
vim.opt.undodir       = os.getenv("HOME") .. "/.vim/undo"
vim.opt.wrap          = false

vim.opt.listchars:append("eol:↴")
vim.opt.wildignore:append("*.pyc")

-- Fix lspsaga now showing diagnostics
vim.diagnostic.config({severity_sort = true})

local yankGrp = vim.api.nvim_create_augroup("TermToggler", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  command = "setlocal nonumber norelativenumber",
  group = yankGrp,
})

-- ============================================
-- Keymaps
-- ============================================

local map = vim.keymap.set

map("", "<Space>", "<Leader>", { remap = true, desc = "[Leader] Map space to leader" })
vim.g.mapleader = " "

-- Window Navigation
map("n", "<C-h>", "<C-W>h", { desc = "[Window] Move to left window" })
map("n", "<C-j>", "<C-W>j", { desc = "[Window] Move to bottom window" })
map("n", "<C-k>", "<C-W>k", { desc = "[Window] Move to top window" })
map("n", "<C-l>", "<C-W>l", { desc = "[Window] Move to right window" })

-- Text Manipulation
map("n", "<leader>z", [[:%s#\<<C-r>=expand("<cword>")<CR>\>#]], { desc = "[Text] Substitute word under cursor" })
map("v", "<C-r>", [["hy:%s#<C-r>h##gc<left><left><left>]], { desc = "[Text] Substitute visual selection" })
map("v", "<leader>y", '"+y', { desc = "[Text] Copy to system clipboard" })

-- Search
map("v", "*", ":call VisualSearch('f')<CR>", { silent = true, desc = "[Search] Search selection forward" })
map("v", "#", ":call VisualSearch('b')<CR>", { silent = true, desc = "[Search] Search selection backward" })
map("v", "gv", ":call VisualSearch('gv')<CR>", { silent = true, desc = "[Search] Grep visual selection" })

-- Git
map("n", "<C-x><C-x>", ":call GitGrepWord()<CR>", { desc = "[Git] Grep word under cursor" })
map("n", "<C-x><C-g>", ":Ack<CR>", { desc = "[Git] Open Ack search" })

-- File
map("n", "<F11>", ":call RunSrc()<CR>", { desc = "[File] Run current file" })
map("n", "<F12>", ":Neoformat<CR>", { desc = "[File] Format with Neoformat" })

-- LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "[LSP] Go to definition" })
map("n", "gh", "<cmd>Lspsaga finder<CR>", { silent = true, desc = "[LSP] Finder" })
map("n", "<leader>f", "<cmd>Lspsaga code_action<CR>", { silent = true, desc = "[LSP] Code action" })
map("v", "<leader>f", "<cmd>Lspsaga range_code_action<CR>", { silent = true, desc = "[LSP] Range code action" })
map("n", "<leader>r", "<cmd>Lspsaga rename<CR>", { silent = true, desc = "[LSP] Rename" })
map("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true, desc = "[LSP] Peek definition" })
map("n", "<leader>cd", "<cmd>Lspsaga show_buf_diagnostics<CR>", { silent = true, desc = "[LSP] Buffer diagnostics" })
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, desc = "[LSP] Prev diagnostic" })
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, desc = "[LSP] Next diagnostic" })
map("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, desc = "[LSP] Prev error" })
map("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, desc = "[LSP] Next error" })
map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true, desc = "[LSP] Outline" })
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = "[LSP] Hover docs" })

-- Help
map("n", "<leader>h", "<cmd>Keymaps<CR>", { desc = "[Help] Show keymaps" })

-- File Tree
map("n", "<F2>", ":NvimTreeToggle<CR>", { desc = "[Tree] Toggle file tree" })

-- Undo
map("n", "<F5>", ":MundoToggle<CR>", { desc = "[Undo] Toggle undo tree" })

-- Tags
map("n", "<F6>", ":TagbarToggle<CR>", { desc = "[Tags] Toggle tagbar" })

-- Terminal
map("n", "<F7>", ":call terminal#toggle()<CR>", { desc = "[Terminal] Toggle terminal" })
map("t", "<F7>", [[<C-\><C-n>:call terminal#toggle()<CR>]], { desc = "[Terminal] Toggle terminal" })

-- Buffer
for i = 1, 9 do
  map("n", "<leader>" .. i, "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>", { silent = true, desc = "[Buffer] Go to buffer " .. i })
end
map("n", "<leader>n", ":BufferLineCycleNext<CR>", { desc = "[Buffer] Next buffer" })
map("n", "<leader>p", ":BufferLineCyclePrev<CR>", { desc = "[Buffer] Previous buffer" })

-- Selection
map("v", "v", "<Plug>(expand_region_expand)", { silent = true, desc = "[Selection] Expand region" })

-- Align
map("x", "ga", "<Plug>(EasyAlign)", { desc = "[Align] EasyAlign (visual)" })
map("n", "ga", "<Plug>(EasyAlign)", { desc = "[Align] EasyAlign (motion)" })

-- Snippet
map("i", "<C-j>", function()
  return vim.fn["vsnip#expandable"]() == 1 and "<Plug>(vsnip-expand)" or "<C-j>"
end, { expr = true, desc = "[Snippet] Expand snippet" })
map("s", "<C-j>", function()
  return vim.fn["vsnip#expandable"]() == 1 and "<Plug>(vsnip-expand)" or "<C-j>"
end, { expr = true, desc = "[Snippet] Expand snippet" })

map("i", "<C-l>", function()
  return vim.fn["vsnip#available"](1) == 1 and "<Plug>(vsnip-expand-or-jump)" or "<C-l>"
end, { expr = true, desc = "[Snippet] Expand or jump" })
map("s", "<C-l>", function()
  return vim.fn["vsnip#available"](1) == 1 and "<Plug>(vsnip-expand-or-jump)" or "<C-l>"
end, { expr = true, desc = "[Snippet] Expand or jump" })

map("i", "<Tab>", function()
  return vim.fn["vsnip#jumpable"](1) == 1 and "<Plug>(vsnip-jump-next)" or "<Tab>"
end, { expr = true, desc = "[Snippet] Jump to next placeholder" })
map("s", "<Tab>", function()
  return vim.fn["vsnip#jumpable"](1) == 1 and "<Plug>(vsnip-jump-next)" or "<Tab>"
end, { expr = true, desc = "[Snippet] Jump to next placeholder" })

map("i", "<S-Tab>", function()
  return vim.fn["vsnip#jumpable"](-1) == 1 and "<Plug>(vsnip-jump-prev)" or "<S-Tab>"
end, { expr = true, desc = "[Snippet] Jump to previous placeholder" })
map("s", "<S-Tab>", function()
  return vim.fn["vsnip#jumpable"](-1) == 1 and "<Plug>(vsnip-jump-prev)" or "<S-Tab>"
end, { expr = true, desc = "[Snippet] Jump to previous placeholder" })

map("n", "s", "<Plug>(vsnip-select-text)", { desc = "[Snippet] Select text" })
map("x", "s", "<Plug>(vsnip-select-text)", { desc = "[Snippet] Select text" })
map("n", "S", "<Plug>(vsnip-cut-text)", { desc = "[Snippet] Cut text" })
map("x", "S", "<Plug>(vsnip-cut-text)", { desc = "[Snippet] Cut text" })
