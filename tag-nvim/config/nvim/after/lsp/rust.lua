---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
    },
  },
}
