local M = {}

M.setup = function(handlers)
  local mason_config = require("mason-lspconfig")
  local lspconfig = require("lspconfig")
  local notify = require("core.messages")

  mason_config.setup({
    ensure_installed = {},
    automatic_installation = false,
  })

  local SKIP = {
    -- Disabling rust_analyzer for the rustaceanvim plugin
    "rust_analyzer",
  }

  -- Function to load our lsp server setups in plugins.lsp.servers or
  -- fallback to a default
  local function mason_lsp_handler(lsp_name)
    -- Skip servers that in the list
    if vim.tbl_contains(SKIP, lsp_name) then
      return
    end

    -- Try to load the server config from "config/nvim/lua/plugins/lsp/servers"
    local ok, custom_handler =
      pcall(require, "plugins.configs.lsp.servers." .. lsp_name)

    -- Use the default if there is no user definition
    if not ok then
      lspconfig[lsp_name].setup(handlers)
      return
    elseif type(custom_handler) == "function" then
      --- Case where language server requires its own setup
      --- Make sure to call require("lspconfig")[lsp_name].setup() in the function
      custom_handler(handlers)
    elseif type(custom_handler) == "table" then
      lspconfig[lsp_name].setup(
        vim.tbl_deep_extend("force", handlers, custom_handler)
      )
    else
      local error_message = string.format(
        [[
          Failed to setup [%s].\n\nServer definition under `completion/servers`
          must return\neither a fun(opts) or a table (got '%s' instead)
        ]],
        lsp_name,
        type(custom_handler)
      )
      notify.error(error_message, "nvim-lspconfig")
    end
  end

  mason_config.setup_handlers({ mason_lsp_handler })
end

return M
