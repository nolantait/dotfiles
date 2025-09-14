---@type vim.lsp.Config
return {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
        zeroUnits = "warning",
        duplicateProperties = "warning",
      },
    },
    scss = { validate = true },
    less = { validate = true },
  },
}
