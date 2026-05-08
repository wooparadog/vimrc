return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- LSP file watcher is too slow on Linux
      local ok, wf = pcall(require, "vim.lsp._watchfiles")
      if ok then
        wf._watchfunc = function()
          return function() end
        end
      end

      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.lsp.enable("pyright")
      vim.lsp.enable("gopls")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("clangd")
      vim.lsp.enable("tailwindcss")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("rust_analyzer")
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    branch = "main",
    event = "LspAttach",
    cmd = "Lspsaga",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      lightbulb = { sign = false },
      symbol_in_winbar = { enable = false },
    },
    keys = {
      { "K",          "<cmd>Lspsaga hover_doc<CR>",             desc = "[LSP] Hover docs" },
      { "gh",         "<cmd>Lspsaga finder<CR>",                desc = "[LSP] Finder" },
      { "<leader>f",  "<cmd>Lspsaga code_action<CR>",           desc = "[LSP] Code action" },
      { "<leader>f",  "<cmd>Lspsaga range_code_action<CR>",     mode = "v", desc = "[LSP] Range code action" },
      { "<leader>r",  "<cmd>Lspsaga rename<CR>",                desc = "[LSP] Rename" },
      { "<leader>gd", "<cmd>Lspsaga peek_definition<CR>",       desc = "[LSP] Peek definition" },
      { "<leader>cd", "<cmd>Lspsaga show_buf_diagnostics<CR>",  desc = "[LSP] Buffer diagnostics" },
      { "<leader>o",  "<cmd>Lspsaga outline<CR>",               desc = "[LSP] Outline" },
      { "[e",         "<cmd>Lspsaga diagnostic_jump_prev<CR>",  desc = "[LSP] Prev diagnostic" },
      { "]e",         "<cmd>Lspsaga diagnostic_jump_next<CR>",  desc = "[LSP] Next diagnostic" },
      {
        "[E",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "[LSP] Prev error",
      },
      {
        "]E",
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "[LSP] Next error",
      },
    },
  },
}
