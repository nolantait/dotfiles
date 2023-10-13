return function()
  local lspconfig = require("lspconfig")
  local mason = require("mason")
  local mason_config = require("mason-lspconfig")
  local handlers = require("plugins.lsp.handlers")

  handlers.setup()

  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  })

  mason_config.setup {
    ensure_installed = {
      "rust_analyzer",
      "bashls",
      "cssls",
      "crystalline",
      "elixirls",
      "tsserver",
      "ruby_ls",
      "tailwindcss",
      "lua_ls"
    },
    automatic_installation = false,
  }

  -- Function to load our lsp server setups in plugins.lsp.servers or
  -- fallback to a default
  local function mason_lsp_handler(lsp_name)
    local __ok, custom_handler = pcall(require, "plugins.lsp.servers." .. lsp_name)
    -- Use preset if there is no user definition
    if not __ok then
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
      vim.notify(
        string.format(
          "Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
          lsp_name,
          type(custom_handler)
        ),
        vim.log.levels.ERROR,
        { title = "nvim-lspconfig" }
      )
    end
  end

  mason_config.setup_handlers({ mason_lsp_handler })
end
