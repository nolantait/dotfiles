local ok, mason = prequire("mason")
if not ok then
  return
end

if mason then
  mason.setup()

  local _ok, mason_config = prequire("mason-lspconfig")
  if not _ok then
    return
  end

  if mason_config then
    mason_config.setup {
      ensure_installed = {
        "rust_analyzer",
        "bashls",
        "cssls",
        "crystalline",
        "elixirls",
        "tsserver",
        "ruby_ls",
        "tailwindcss",
        "lua_ls"
      },
      automatic_installation = false,
    }

    local servers = require("user.lsp.servers")
    mason_config.setup_handlers(servers)
  end
end
