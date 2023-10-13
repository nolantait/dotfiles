return function()
  local dap = require("dap")
  local dapui = require("dapui")
  local mason_dap = require("mason-nvim-dap")

  local colors = require("globals.colors")
  local icons = require("globals.icons")
  local notify = require("core.messages")

  -- Initialize debug hooks
  _G._debugging = false
  local function debug_init_cb()
    _G._debugging = true
    dapui.open({ reset = true })
  end
  local function debug_terminate_cb()
    if _debugging then
      _G._debugging = false
      dapui.close()
    end
  end
  dap.listeners.after.event_initialized["dapui_config"] = debug_init_cb
  dap.listeners.before.event_terminated["dapui_config"] = debug_terminate_cb
  dap.listeners.before.event_exited["dapui_config"] = debug_terminate_cb
  dap.listeners.before.disconnect["dapui_config"] = debug_terminate_cb

  -- We need to override nvim-dap's default highlight groups, AFTER requiring nvim-dap for catppuccin.
  vim.api.nvim_set_hl(0, "DapStopped", { fg = colors.green })

  vim.fn.sign_define(
    "DapBreakpoint",
    {
      text = icons.dap.breakpoint,
      texthl = "DapBreakpoint",
      linehl = "",
      numhl = ""
    }
  )

  vim.fn.sign_define(
    "DapBreakpointCondition",
    {
      text = icons.dap.breakpoint_condition,
      texthl = "DapBreakpoint",
      linehl = "",
      numhl = ""
    }
  )

  vim.fn.sign_define(
    "DapStopped",
    {
      text = icons.dap.stopped,
      texthl = "DapStopped",
      linehl = "",
      numhl = ""
    }
  )

  vim.fn.sign_define(
    "DapBreakpointRejected",
    {
      text = icons.dap.breakpoint_rejected,
      texthl = "DapBreakpoint",
      linehl = "",
      numhl = ""
    }
  )

  vim.fn.sign_define(
    "DapLogPoint",
    {
      text = icons.dap.log_point,
      texthl = "DapLogPoint",
      linehl = "",
      numhl = ""
    }
  )

  ---A handler to setup all clients defined under `plugins/config/dap/clients/*.lua`
  ---@param config table
  local function mason_dap_handler(config)
    local dap_name = config.name
    local ok, custom_handler = pcall(require, "plugins.configs.dap.clients." .. dap_name)

    if not ok then
      -- Default to use factory config for clients(s) that doesn't include a spec
      mason_dap.default_setup(config)
      return
    elseif type(custom_handler) == "function" then
      -- Case where the protocol requires its own setup
      -- Make sure to set
      -- * dap.adpaters.<dap_name> = { your config }
      -- * dap.configurations.<lang> = { your config }
      -- See `codelldb.lua` for a concrete example.
      custom_handler(config)
    else
      local error_message = string.format(
        "Failed to setup [%s].\n\nClient definition under `plugins/configs/dap/clients` must return\na fun(opts) (got '%s' instead)",
        config.name,
        type(custom_handler)
      )
      notify.error(
        error_message,
        "nvim-dap"
      )
    end
  end

  mason_dap.setup({
    ensure_installed = {},
    automatic_installation = true,
    handlers = { mason_dap_handler },
  })

  -- Setup ruby dap
  local ruby_dap = require("dap-ruby")
  ruby_dap.setup()
end
