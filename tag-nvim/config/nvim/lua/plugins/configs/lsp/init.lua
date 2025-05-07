return function()
  local handlers = require("plugins.configs.lsp.handlers")

  vim.lsp.config("*", {
    capabilities = handlers.capabilities,
    on_attach = handlers.on_attach,
  })

  vim.lsp.enable("ruby_lsp")
  vim.lsp.enable("lua_ls")
  vim.lsp.enable("ts_ls")
  vim.lsp.enable("ansiblels")

  require("plugins.configs.lsp.mason").setup()
  require("plugins.configs.lsp.diagnostics").setup()
  require("plugins.configs.lsp.cmp").setup(handlers)
end
