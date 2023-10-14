return function()
  local mason = require("plugins.configs.lsp.mason")
  local mason_config = require("plugins.configs.lsp.mason-lspconfig")
  local neodev = require("plugins.configs.lsp.neodev")
  local handlers = require("plugins.configs.lsp.handlers")
  local cmp = require("plugins.configs.lsp.cmp-nvim-lsp")

  require("lspconfig.ui.windows").default_options.border = "rounded"

  neodev.setup()
  mason.setup()
  handlers.setup()
  cmp.setup(handlers)
  mason_config.setup(handlers)
end
