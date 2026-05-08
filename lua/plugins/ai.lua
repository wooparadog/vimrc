return {
  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      detect_proxy = true,
      enable_chat = true,
    },
  },
  {
    "yetone/avante.nvim",
    branch = "main",
    build = "make",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "MunifTanjim/nui.nvim",
      "HakonHarnes/img-clip.nvim",
      "echasnovski/mini.pick",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      mode = "legacy",
      provider = "openrouter",
      providers = {
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          model = "anthropic/claude-3.7-sonnet",
          proxy = "http://192.168.100.2:8118",
          api_key_name = "OPENROUTER_APIKEY",
        },
      },
      file_selector = {
        provider = "mini.pick",
        suggestion = {
          debounce = 600,
          throttle = 600,
        },
      },
    },
    config = function(_, opts)
      pcall(function() require("avante_lib").load() end)
      require("avante").setup(opts)
    end,
  },
  { "HakonHarnes/img-clip.nvim", lazy = true, opts = {} },
  { "echasnovski/mini.pick",     lazy = true, opts = {} },
  { "stevearc/dressing.nvim",    lazy = true },
  { "MunifTanjim/nui.nvim",      lazy = true },
}
