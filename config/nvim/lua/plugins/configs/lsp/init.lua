return function()
  local mason = require("plugins.configs.lsp.mason")
  local mason_config = require("plugins.configs.lsp.mason-lspconfig")
  local handlers = require("plugins.configs.lsp.handlers")

  mason.setup()
  handlers.setup()
  mason_config.setup(handlers)
end
