return {
  -- Icons (used by feline, bufferline, nvim-tree, lspsaga)
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
    "feline-nvim/feline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lsp = require("feline.providers.lsp")
      local vi_mode_utils = require("feline.providers.vi_mode")

      local colors = {
        bg = "#282828", black = "#282828", yellow = "#d8a657", cyan = "#89b482",
        oceanblue = "#45707a", green = "#a9b665", orange = "#e78a4e",
        violet = "#d3869b", magenta = "#c14a4a", white = "#a89984",
        fg = "#a89984", skyblue = "#7daea3", red = "#ea6962",
      }

      local vi_mode_colors = {
        NORMAL = "green", OP = "green", INSERT = "red", CONFIRM = "red",
        VISUAL = "skyblue", LINES = "skyblue", BLOCK = "skyblue",
        REPLACE = "violet", ["V-REPLACE"] = "violet",
        ENTER = "cyan", MORE = "cyan", SELECT = "orange",
        COMMAND = "green", SHELL = "green", TERM = "green", NONE = "yellow",
      }

      local vi_mode_text = {
        NORMAL = "<|", OP = "<|", INSERT = "|>", VISUAL = "<>",
        LINES = "<>", BLOCK = "<>", REPLACE = "<>", ["V-REPLACE"] = "<>",
        ENTER = "<>", MORE = "<>", SELECT = "<>",
        COMMAND = "<|", SHELL = "<|", TERM = "<|", NONE = "<>", CONFIRM = "|>",
      }

      local force_inactive = {
        filetypes = { "NvimTree", "dbui", "packer", "startify", "fugitive", "fugitiveblame" },
        buftypes = { "terminal" },
        bufnames = {},
      }

      local components = { active = { {}, {}, {} }, inactive = { {}, {}, {} } }

      -- LEFT
      components.active[1][1] = {
        provider = " NV-IDE ",
        hl = function()
          return { bg = vi_mode_utils.get_mode_color(), fg = "black", style = "bold" }
        end,
        right_sep = " ",
      }
      components.active[1][2] = {
        provider = function() return vi_mode_text[vi_mode_utils.get_vim_mode()] end,
        hl = function()
          return { fg = vi_mode_utils.get_mode_color(), bg = "bg", style = "bold" }
        end,
        right_sep = " ",
      }
      components.active[1][3] = {
        provider = function() return vim.fn.expand("%:F") end,
        hl = { fg = "white", bg = "bg", style = "bold" },
        right_sep = { str = " > ", hl = { fg = "white", bg = "bg", style = "bold" } },
      }

      -- MID
      components.active[2][1] = { provider = "git_branch",       hl = { fg = "yellow", bg = "bg", style = "bold" } }
      components.active[2][2] = { provider = "git_diff_added",   hl = { fg = "green",  bg = "bg", style = "bold" } }
      components.active[2][3] = { provider = "git_diff_changed", hl = { fg = "orange", bg = "bg", style = "bold" } }
      components.active[2][4] = { provider = "git_diff_removed", hl = { fg = "red",    bg = "bg", style = "bold" } }
      components.active[2][5] = {
        provider = "diagnostic_errors",
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
        hl = { fg = "red", style = "bold" },
      }
      components.active[2][6] = {
        provider = "diagnostic_warnings",
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
        hl = { fg = "yellow", style = "bold" },
      }
      components.active[2][7] = {
        provider = "diagnostic_hints",
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
        hl = { fg = "cyan", style = "bold" },
      }
      components.active[2][8] = {
        provider = "diagnostic_info",
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
        hl = { fg = "skyblue", style = "bold" },
      }

      -- RIGHT
      components.active[3][1] = {
        provider = "lsp_client_names",
        hl = { fg = "yellow", bg = "bg", style = "bold" },
        right_sep = " ",
      }

      local function file_icon_color()
        local filename = vim.fn.expand("%:t")
        local extension = vim.fn.expand("%:e")
        local icon, name = require("nvim-web-devicons").get_icon(filename, extension)
        local fg = "white"
        if icon ~= nil then
          fg = vim.fn.synIDattr(vim.fn.hlID(name), "fg")
        end
        return { fg = fg, bg = "bg", style = "bold" }
      end

      components.active[3][2] = {
        provider = function()
          local filename = vim.fn.expand("%:t")
          local extension = vim.fn.expand("%:e")
          local icon = require("nvim-web-devicons").get_icon(filename, extension)
          return icon or ""
        end,
        hl = file_icon_color,
        right_sep = " ",
      }
      components.active[3][3] = { provider = "file_type",     hl = file_icon_color, right_sep = " " }
      components.active[3][4] = {
        provider = "file_size",
        enabled = function() return vim.fn.getfsize(vim.fn.expand("%:t")) > 0 end,
        hl = { fg = "skyblue", bg = "bg", style = "bold" },
        right_sep = " ",
      }
      components.active[3][5] = {
        provider = function() return vim.bo.fileformat:upper() end,
        hl = { fg = "white", bg = "bg", style = "bold" },
        right_sep = " ",
      }
      components.active[3][6] = { provider = "file_encoding",  hl = { fg = "white", bg = "bg", style = "bold" }, right_sep = " " }
      components.active[3][7] = { provider = "position",       hl = { fg = "white", bg = "bg", style = "bold" }, right_sep = " " }
      components.active[3][8] = { provider = "line_percentage",hl = { fg = "white", bg = "bg", style = "bold" }, right_sep = " " }
      components.active[3][9] = { provider = "scroll_bar",     hl = { fg = "yellow", bg = "bg" } }

      -- INACTIVE
      components.inactive[1][1] = {
        provider = "file_type",
        hl = { fg = "black", bg = "cyan", style = "bold" },
        left_sep = { str = " ", hl = { fg = "NONE", bg = "cyan" } },
        right_sep = {
          { str = " ", hl = { fg = "NONE", bg = "cyan" } },
          " ",
        },
      }

      require("feline").setup({
        theme = colors,
        vi_mode_colors = vi_mode_colors,
        components = components,
        force_inactive = force_inactive,
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
