return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    init = function()
      vim.g["prettier#autoformat"] = 0
      vim.g["prettier#autoformat_require_pragma"] = 0
    end,
  },
}
