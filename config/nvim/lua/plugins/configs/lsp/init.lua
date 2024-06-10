return function()
  local mason = require("plugins.configs.lsp.mason")
  local mason_config = require("plugins.configs.lsp.mason-lspconfig")
  local handlers = require("plugins.configs.lsp.handlers")
  local cmp = require("plugins.configs.lsp.cmp-nvim-lsp")

  mason.setup()
  handlers.setup()
  cmp.setup(handlers)
  mason_config.setup(handlers)
end
