local lsp_zero_config = {
  -- Find the language servers in the global package scope.
  -- In NixOS we want to manage all our packages including language
  -- servers and programming languages. So we need to avoid convenient
  -- tools like Mason which install them locally outside of NixOS.
  call_servers = "global",
}

local lsp_servers = {
  "ruby_lsp",
  "ts_ls",
}

return function()
  local handlers = require("plugins.configs.lsp.handlers")
  local cmp = require("plugins.configs.lsp.cmp-nvim-lsp")
  local lsp = require('lsp-zero')

  handlers.setup()
  cmp.setup(handlers)

  lsp.extend_lspconfig({
    lsp_attach = handlers.on_attach,
    capabilities = handlers.capabilities
  })

  -- lsp.configure("lua_ls", lua_ls_config)

  lsp.setup_servers(lsp_servers, lsp_zero_config)
  lsp.setup()
end
