#! /usr/bin/env lua

local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
   -- disable lsp watcher. Too slow on linux
   wf._watchfunc = function()
     return function() end
   end
end

local navic = require("nvim-navic")

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
require('lspconfig').ts_ls.setup{
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}
require('lspconfig').clangd.setup{}
require('lspconfig').tailwindcss.setup{}
require('lspconfig').rust_analyzer.setup{}
require('lspconfig').lua_ls.setup{}

-- Others
require('gitsigns').setup()
require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp"
  }
}


-- Complete engines
require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("codeium").setup({detect_proxy = true, enable_chat = true})
require('complete')

require('statusline')
require('browser')
require('treesitter')

require('diff')
require('saga')

-- Avante
-- deps:
require('img-clip').setup ({
  -- use recommended settings from above
})
require('avante_lib').load()
require('avante').setup ({
  provider = "openai",
  openai = {
    endpoint = "https://openrouter.ai/api/v1",
    model = "anthropic/claude-3.5-sonnet",
    proxy = "http://192.168.100.2:8118",
    api_key_name = "OPENROUTER_APIKEY",
  }
})

require("colorizer").setup({
  filetypes = { "*" },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = true, -- "Name" codes like Blue or blue
    RRGGBBAA = false, -- #RRGGBBAA hex codes
    AARRGGBB = false, -- 0xAARRGGBB hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Highlighting mode.  'background'|'foreground'|'virtualtext'
    mode = "background", -- Set the display mode
    -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True is same as normal
    tailwind = true, -- Enable tailwind colors
    -- parsers can contain values used in |user_default_options|
    sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
    -- Virtualtext character to use
    virtualtext = "■",
    -- Display virtualtext inline with color
    virtualtext_inline = false,
    -- Virtualtext highlight mode: 'background'|'foreground'
    virtualtext_mode = "foreground",
    -- update color values even if buffer is not focused
    -- example use: cmp_menu, cmp_docs
    always_update = true,
  },
  -- all the sub-options of filetypes apply to buftypes
  buftypes = {},
  -- Boolean | List of usercommands to enable
  user_commands = true, -- Enable all or some usercommands

})
