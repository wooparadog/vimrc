return {
  {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile" },
    keys = {
      { "<F2>", "<cmd>NvimTreeToggle<CR>", desc = "[Tree] Toggle file tree" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      update_focused_file = { enable = false },
    },
  },
}
