-- DOCS: LSP setup with mason which will handle the installation of LSP servers

local icons = require("globals.icons")

return {
  {
    "mason-org/mason.nvim",
    init = function()
      local handlers = require("utils.lsp.handlers")
      local diagnostics = require("utils.lsp.diagnostics")

      diagnostics.setup()

      -- Sets up default LSP handlers
      vim.lsp.config("*", {
        capabilities = handlers.capabilities,
        on_attach = handlers.on_attach,
      })

      local complete_client = function(arg)
        return vim
          .iter(vim.lsp.get_clients())
          :map(function(client)
            return client.name
          end)
          :filter(function(name)
            return name:sub(1, #arg) == arg
          end)
          :totable()
      end

      vim.api.nvim_create_user_command("LspRestart", function(info)
        local clients = info.fargs

        -- Default to restarting all active servers
        if #clients == 0 then
          clients = vim
            .iter(vim.lsp.get_clients())
            :map(function(client)
              return client.name
            end)
            :totable()
        end

        for _, name in ipairs(clients) do
          if vim.lsp.config[name] == nil then
            if name ~= "copilot" then
              vim.notify(("Invalid server name '%s'"):format(name))
            end
          else
            vim.lsp.enable(name, false)
          end
        end

        local timer = assert(vim.uv.new_timer())
        timer:start(500, 0, function()
          for _, name in ipairs(clients) do
            vim.schedule_wrap(function(x)
              vim.lsp.enable(x)
            end)(name)
          end
        end)
      end, {
        desc = "Restart the given client",
        nargs = "?",
        complete = complete_client,
      })

      vim.api.nvim_create_user_command("LspLog", function()
        local log_path = vim.lsp.get_log_path()

        if log_path then
          vim.cmd("edit " .. log_path)
        else
          print("No LSP logs found.")
        end
      end, {
        desc = "Open LSP logs",
      })
    end,
    keys = {
      {
        "gT",
        mode = "n",
        desc = "Go to type definition",
        function()
          vim.lsp.buf.type_definition()
        end,
      },
      {
        "gd",
        mode = "n",
        desc = "Go to definition",
        function()
          vim.lsp.buf.definition()
        end,
      },
      {
        "K",
        mode = "n",
        desc = "Show hover",
        function()
          vim.lsp.buf.hover()
        end,
      },
      {
        "<Leader>rn",
        mode = "n",
        desc = "Rename symbol",
        function()
          vim.lsp.buf.rename()
        end,
      },
      {
        "<Leader>ca",
        mode = "n",
        desc = "Code action",
        function()
          vim.lsp.buf.code_action()
        end,
      },
      {
        "gr",
        mode = "n",
        desc = "Go to references",
        function()
          vim.lsp.buf.references()
        end,
      },
      {
        "gi",
        mode = "n",
        desc = "Go to implementation",
        function()
          vim.lsp.buf.implementation()
        end,
      },
      {
        "?",
        mode = "n",
        desc = "Open diagnostic float window",
        function()
          vim.diagnostic.open_float({ max_height = 400 })
        end,
      },
      {
        "[d",
        mode = "n",
        desc = "Go to previous diagnostic",
        function()
          vim.diagnostic.goto_prev()
        end,
      },
      {
        "]d",
        mode = "n",
        desc = "Go to next diagnostic",
        function()
          vim.diagnostic.goto_next()
        end,
      },
      {
        "<leader>ih",
        mode = "n",
        desc = "Toggle inlay hints",
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end,
      },
    },
    lazy = false,
    opts = {
      ui = {
        icons = {
          package_installed = icons.check,
          package_pending = icons.download,
          package_uninstalled = icons.x_mark,
        },
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
    },
  },
  {
    "RubixDev/mason-update-all",
    cmd = "MasonUpdateAll",
    -- Use the default calling of require(MAIN).setup(opts) which in this case
    -- would call .setup({})
    config = true,
  },
}
