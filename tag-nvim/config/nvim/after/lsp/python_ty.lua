---@type vim.lsp.Config
return {
  cmd = { "ty", "server" },
  filetypes = { "python" },
  root_markers = {
    {
      "pyproject.toml",
      "ty.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
    },
    ".git",
  },
}
