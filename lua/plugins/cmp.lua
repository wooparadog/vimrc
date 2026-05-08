return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/vim-vsnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
        }),
        sources = {
          { name = "codeium" },
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "nvim_lua" },
          { name = "buffer" },
        },
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({ { name = "cmp_git" } }, { { name = "buffer" } }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },
  {
    "hrsh7th/vim-vsnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = { "InsertEnter" },
    keys = {
      {
        "<C-j>",
        function()
          return vim.fn["vsnip#expandable"]() == 1 and "<Plug>(vsnip-expand)" or "<C-j>"
        end,
        mode = { "i", "s" },
        expr = true,
        desc = "[Snippet] Expand snippet",
      },
      {
        "<C-l>",
        function()
          return vim.fn["vsnip#available"](1) == 1 and "<Plug>(vsnip-expand-or-jump)" or "<C-l>"
        end,
        mode = { "i", "s" },
        expr = true,
        desc = "[Snippet] Expand or jump",
      },
      {
        "<Tab>",
        function()
          return vim.fn["vsnip#jumpable"](1) == 1 and "<Plug>(vsnip-jump-next)" or "<Tab>"
        end,
        mode = { "i", "s" },
        expr = true,
        desc = "[Snippet] Jump to next placeholder",
      },
      {
        "<S-Tab>",
        function()
          return vim.fn["vsnip#jumpable"](-1) == 1 and "<Plug>(vsnip-jump-prev)" or "<S-Tab>"
        end,
        mode = { "i", "s" },
        expr = true,
        desc = "[Snippet] Jump to previous placeholder",
      },
      { "s", "<Plug>(vsnip-select-text)", mode = { "n", "x" }, desc = "[Snippet] Select text" },
      { "S", "<Plug>(vsnip-cut-text)",    mode = { "n", "x" }, desc = "[Snippet] Cut text" },
    },
  },
}
