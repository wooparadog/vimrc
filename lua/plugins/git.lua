return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  { "airblade/vim-gitgutter", event = "VeryLazy" },

  {
    "tpope/vim-fugitive",
    cmd = {
      "G", "Git", "Gdiff", "Gdiffsplit", "Gvdiffsplit",
      "Gread", "Gwrite", "Ggrep", "GMove", "GDelete",
      "GBrowse", "Gstatus", "Gblame",
    },
  },

  {
    "mattn/gist-vim",
    cmd = "Gist",
    dependencies = { "mattn/webapi-vim" },
    init = function()
      vim.g.gist_show_privates = 1
    end,
  },

  { "mattn/webapi-vim", lazy = true },

  { "codeindulgence/vim-tig", cmd = "Tig", init = function() vim.g.tig_default_command = "" end },

  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles",
      "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory",
    },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          default = { layout = "diff2_horizontal", winbar_info = false },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = { layout = "diff2_horizontal", winbar_info = false },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = { position = "left", width = 35, win_opts = {} },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = { diff_merges = "combined" },
              multi_file  = { diff_merges = "first-parent" },
            },
            hg = { single_file = {}, multi_file = {} },
          },
          win_config = { position = "bottom", height = 16, win_opts = {} },
        },
        commit_log_panel = { win_config = { win_opts = {} } },
        default_args = { DiffviewOpen = {}, DiffviewFileHistory = {} },
        hooks = {},
        keymaps = {
          disable_defaults = false,
          view = {
            { "n", "<leader>e",  actions.focus_files,                { desc = "Focus file panel" } },
            { "n", "<leader>b",  actions.toggle_files,               { desc = "Toggle file panel" } },
            { "n", "g<C-x>",     actions.cycle_layout,               { desc = "Cycle layout" } },
            { "n", "[x",         actions.prev_conflict,              { desc = "Prev conflict" } },
            { "n", "]x",         actions.next_conflict,              { desc = "Next conflict" } },
            { "n", "<leader>co", actions.conflict_choose("ours"),    { desc = "Choose OURS" } },
            { "n", "<leader>ct", actions.conflict_choose("theirs"),  { desc = "Choose THEIRS" } },
            { "n", "<leader>cb", actions.conflict_choose("base"),    { desc = "Choose BASE" } },
            { "n", "<leader>ca", actions.conflict_choose("all"),     { desc = "Choose ALL" } },
            { "n", "dx",         actions.conflict_choose("none"),    { desc = "Delete conflict region" } },
          },
        },
      })
    end,
  },
}
