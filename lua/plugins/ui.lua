return {
  -- Icons (used by lualine, bufferline, nvim-tree, lspsaga)
  {
    "nvim-tree/nvim-web-devicons",
    -- kyazdani42/nvim-web-devicons was the historic name; the project has
    -- since moved to nvim-tree/. Lazy will follow redirects either way, but
    -- using the canonical name avoids spurious "moved" warnings.
    lazy = true,
  },

  {
    "nathanaelkane/vim-indent-guides",
    event = "VeryLazy",
    -- ftplugin/{python,typescript}.vim run :IndentGuidesEnable during
    -- FileType, which fires before VeryLazy. cmd= ensures lazy loads
    -- the plugin on first invocation of any of these commands.
    cmd = { "IndentGuidesEnable", "IndentGuidesDisable", "IndentGuidesToggle" },
    init = function()
      vim.g.indent_guides_guide_size = 1
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { diagnostics = "nvim_lsp" },
    },
    keys = (function()
      local keys = {
        { "<leader>n", "<cmd>BufferLineCycleNext<CR>", desc = "[Buffer] Next buffer" },
        { "<leader>p", "<cmd>BufferLineCyclePrev<CR>", desc = "[Buffer] Previous buffer" },
      }
      for i = 1, 9 do
        table.insert(keys, {
          "<leader>" .. i,
          "<cmd>BufferLineGoToBuffer " .. i .. "<CR>",
          desc = "[Buffer] Go to buffer " .. i,
        })
      end
      return keys
    end)(),
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
    config = function()
      local navic = require("nvim-navic")

      -- Names of the LSP servers attached to the current buffer.
      local function lsp_clients()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return ""
        end
        local names = {}
        for _, client in ipairs(clients) do
          names[#names + 1] = client.name
        end
        return table.concat(names, " ")
      end

      require("lualine").setup({
        options = {
          theme = "auto",          -- derives a palette from the active colorscheme
          icons_enabled = true,
          globalstatus = true,     -- single statusline (matches laststatus=3)
          component_separators = "",
          section_separators = "",
          disabled_filetypes = {
            statusline = { "NvimTree", "startify", "fugitive", "fugitiveblame" },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "diff" },  -- git +/~/- counts; branch intentionally omitted
          lualine_c = {
            { "filename", path = 2 }, -- absolute path
            -- Code-location breadcrumb via nvim-navic. Lives in the statusline
            -- (not a winbar) so it never shifts buffer lines or misaligns
            -- scroll-bound `:Git blame` splits.
            {
              function() return navic.get_location() end,
              cond = function() return navic.is_available() end,
            },
          },
          lualine_x = {
            { "diagnostics", sources = { "nvim_diagnostic" } }, -- left of the LSP name
            lsp_clients,
            "filetype",
            "filesize",
            "fileformat",
            "encoding",
          },
          lualine_y = { "location" },  -- line:col
          lualine_z = { "progress" },  -- % through file
        },
      })
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = false,
        AARRGGBB = false,
        rgb_fn = false,
        hsl_fn = false,
        css = false,
        css_fn = false,
        mode = "background",
        tailwind = true,
        sass = { enable = false, parsers = { "css" } },
        virtualtext = "■",
        virtualtext_inline = false,
        virtualtext_mode = "foreground",
        always_update = true,
      },
      buftypes = {},
      user_commands = true,
    },
    config = function(_, opts)
      require("colorizer").setup(opts)
    end,
  },

  -- Smooth scrolling
  { "psliwka/vim-smoothie", event = "VeryLazy" },

  -- Startup screen
  {
    "mhinz/vim-startify",
    lazy = false,
    init = function()
      vim.g.startify_files_number = 20
      vim.g.startify_change_to_dir = 0
      vim.g.startify_change_to_vcs_root = 1
    end,
  },
}
