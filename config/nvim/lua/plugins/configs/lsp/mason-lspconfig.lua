local M = {}

M.setup = function(handlers)
  local mason_config = require("mason-lspconfig")
  local lspconfig = require("lspconfig")
  local notify = require("core.messages")

  mason_config.setup({
    ensure_installed = {
      "rust_analyzer",
      "bashls",
      "cssls",
      "crystalline",
      "elixirls",
      "ruby_ls",
      "tailwindcss",
      "lua_ls"
    },
    automatic_installation = false,
  })

  -- Function to load our lsp server setups in plugins.lsp.servers or
  -- fallback to a default
  local function mason_lsp_handler(lsp_name)
    local ok, custom_handler = pcall(require, "plugins.configs.lsp.servers." .. lsp_name)
    -- Use preset if there is no user definition
    if not ok then
      -- Default to use factory config for server(s) that doesn't include a spec
      lspconfig[lsp_name].setup(handlers)
      return
    elseif type(custom_handler) == "function" then
      --- Case where language server requires its own setup
      --- Make sure to call require("lspconfig")[lsp_name].setup() in the function
      --- See `clangd.lua` for example.
      custom_handler(handlers)
    elseif type(custom_handler) == "table" then
      lspconfig[lsp_name].setup(vim.tbl_deep_extend("force", handlers, custom_handler))
    else
      local error_message = string.format(
        "Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
        lsp_name,
        type(custom_handler)
      )
      notify.error(
        error_message,
        "nvim-lspconfig"
      )
    end
  end

  mason_config.setup_handlers({ mason_lsp_handler })
end

return M
