-- DOCS: Render markdown files

return {
  {
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante", "AgenticChat", "opencode_output" },
    opts = {
      -- anti_conceal = { enabled = false },
      file_types = { "markdown", "Avante", "AgenticChat", "opencode_output" },
      completions = {
        lsp = { enabled = true },
      },
    },
  },
}
