-- DOCS: LSP capabilities for nvim-cmp

local M = {}

M.setup = function(handlers)
  local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    handlers.capabilities = cmp_lsp.default_capabilities(handlers.capabilities)
  end
end

return M
