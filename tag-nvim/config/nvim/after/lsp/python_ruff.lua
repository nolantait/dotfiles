---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    {
      "pyproject.toml",
      "ruff.toml",
      ".ruff.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
    },
    ".git",
  },
  -- Ruff server reads its own settings from `init_options.settings` (see
  -- https://docs.astral.sh/ruff/editors/settings/). The `settings.python.analysis`
  -- options that used to live here are Pyright's and are ignored by Ruff.
  init_options = {
    settings = {
      logLevel = "error",
    },
  },
}
