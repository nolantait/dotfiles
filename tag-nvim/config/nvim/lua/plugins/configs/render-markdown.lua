-- DOCS: Render markdown files

return function()
  local markdown = require("render-markdown")

  markdown.setup({
    file_types = { "markdown", "Avante" },
    completions = {
      lsp = { enabled = true },
    },
  })
end
