-- Setup options

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
vim.opt.undodir       = "$HOME/.vim/undo"
vim.opt.undofile      = true
vim.opt.wrap          = false

vim.opt.listchars:append("eol:↴")
vim.opt.wildignore:append("*.pyc")

-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    { name = 'nvim_lua' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').pyright.setup{}
require('lspconfig').gopls.setup{}
require('nvim-tree').setup{}
require('gitsigns').setup()
require('feline').setup()
require("bufferline").setup{}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { 'lua', 'python', 'go', 'typescript'},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
