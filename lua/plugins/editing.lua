return {
  -- Surround / commenting / motion / region
  { "tpope/vim-surround",            event = "VeryLazy" },
  { "scrooloose/nerdcommenter",      event = "VeryLazy" },
  { "michaeljsmith/vim-indent-object", event = "VeryLazy" },
  { "vim-scripts/matchit.zip",       event = "VeryLazy" },
  { "mg979/vim-visual-multi",        event = "VeryLazy" },

  -- Region expansion
  {
    "terryma/vim-expand-region",
    keys = {
      { "v", "<Plug>(expand_region_expand)", mode = "v", silent = true, desc = "[Selection] Expand region" },
    },
  },

  -- Easy align
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "[Align] EasyAlign" },
    },
  },

  -- Formatter
  {
    "sbdchd/neoformat",
    cmd = "Neoformat",
  },

  -- Linter (ALE)
  {
    "dense-analysis/ale",
    event = { "BufReadPost", "BufNewFile" },
  },
}
