-- DOCS: Render markdown files

return {
  {
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    opts = {
      file_types = { "markdown", "Avante" },
      completions = {
        lsp = { enabled = true },
      },
    },
  },
}
