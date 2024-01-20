-- DOCS: Sets up Debugger Adapter Protocol

return function()
  local colors = require("globals.colors")
  local icons = require("globals.icons")

  local dap = require("dap")
  local dapui = require("dapui")

  -- -- Initialize debug hooks
  -- _G._debugging = false
  -- local function debug_init_cb()
  --   _G._debugging = true
  --   dapui.open({ reset = true })
  -- end
  --
  -- local function debug_terminate_cb()
  --   if _debugging then
  --     _G._debugging = false
  --     dapui.close()
  --   end
  -- end

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  dap.adapters.ruby = function(callback, config)
    callback {
      type = "server",
      host = "127.0.0.1",
      port = "${port}",
      executable = {
        command = "bundle",
        args = {
          "exec",
          "rdbg",
          "-n",
          "--open",
          "--port",
          "${port}",
          "-c",
          "--",
          "bundle",
          "exec",
          config.command,
          config.script,
        },
      },
    }
  end

  dap.configurations.ruby = {
    {
      type = "ruby",
      name = "run current spec file",
      request = "attach",
      localfs = true,
      command = "rspec",
      script = "${file}",
    },
    {
      type = "ruby",
      name = "debug current file",
      request = "attach",
      localfs = true,
      command = "ruby",
      script = "${file}",
    },
  }

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
end
