return function()
  local mason = require("plugins.configs.lsp.mason")
  local mason_config = require("plugins.configs.lsp.mason-lspconfig")
  local neodev = require("plugins.configs.lsp.neodev")
  local handlers = require("plugins.configs.lsp.handlers")

  require("lspconfig.ui.windows").default_options.border = "rounded"

  neodev.setup()
  mason.setup()
  handlers.setup()
  mason_config.setup(handlers)
end
