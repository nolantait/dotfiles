return function()
  local mason = require("plugins.configs.lsp.mason")
  mason.setup()

  local handlers = require("plugins.configs.lsp.handlers")
  handlers.setup()

  local cmp = require("plugins.configs.lsp.cmp-nvim-lsp")
  cmp.setup(handlers)

  local mason_config = require("plugins.configs.lsp.mason-lspconfig")
  mason_config.setup(handlers)
end
