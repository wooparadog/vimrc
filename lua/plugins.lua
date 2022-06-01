#! /usr/bin/env lua

require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').pyright.setup{}
require('lspconfig').gopls.setup{}
require('lspconfig').tsserver.setup{}
require('lspconfig').clangd.setup{}

-- Others
require('gitsigns').setup()
require("bufferline").setup{}
require("nvim-gps").setup()

require('statusline')
require('complete')
require('browser')
require('treesitter')
