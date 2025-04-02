return function()
  local handlers = require("plugins.configs.lsp.handlers")

  require("plugins.configs.lsp.mason").setup()
  require("plugins.configs.lsp.diagnostics").setup()
  require("plugins.configs.lsp.cmp").setup(handlers)
  require("plugins.configs.lsp.servers").setup(handlers)
end
