#! /usr/bin/env lua

local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
   -- disable lsp watcher. Too slow on linux
   wf._watchfunc = function()
     return function() end
   end
end

local navic = require("nvim-navic")

require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').pyright.setup{
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}
require('lspconfig').gopls.setup{
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}
require('lspconfig').tsserver.setup{
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}
require('lspconfig').clangd.setup{}
require('lspconfig').tailwindcss.setup{}

-- Others
require('gitsigns').setup()
require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp"
  }
}

require('statusline')
require('complete')
require('browser')
require('treesitter')

require('diff')
require('github_copilot')
require('saga')
