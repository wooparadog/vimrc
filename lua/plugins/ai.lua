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
}
