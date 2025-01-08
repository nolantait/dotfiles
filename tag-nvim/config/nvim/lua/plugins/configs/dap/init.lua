-- DOCS: Sets up Debugger Adapter Protocol

return function()
  local colors = require("globals.colors")
  local icons = require("globals.icons")

  local dap = require("dap")
  local dapui = require("dapui")

  -- Initialize debug hooks
  _G._debugging = false
  local function debug_init()
    _G._debugging = true
    dapui.open({ reset = true })
  end

  local function debug_terminate()
    if _debugging then
      _G._debugging = false
      dapui.close()
    end
  end

  dap.listeners.before.attach.dapui_config = debug_init
  dap.listeners.before.launch.dapui_config = debug_init
  dap.listeners.before.event_terminated.dapui_config = debug_terminate
  dap.listeners.before.event_exited.dapui_config = debug_terminate

  dap.adapters.ruby = function(callback, config)
    callback({
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
    })
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

  -- Remap K to hover over variables only during debugging sessions
  local api = vim.api
  local keymap_restore = {}

  dap.listeners.after["event_initialized"]["me"] = function()
    for _, buf in pairs(api.nvim_list_bufs()) do
      local keymaps = api.nvim_buf_get_keymap(buf, "n")
      for _, keymap in pairs(keymaps) do
        if keymap.lhs == "K" then
          table.insert(keymap_restore, keymap)
          api.nvim_buf_del_keymap(buf, "n", "K")
        end
      end
    end
    api.nvim_set_keymap(
      "n",
      "K",
      '<Cmd>lua require("dap.ui.widgets").hover()<CR>',
      { silent = true }
    )
  end

  dap.listeners.after["event_terminated"]["me"] = function()
    for _, keymap in pairs(keymap_restore) do
      api.nvim_buf_set_keymap(
        keymap.buffer,
        keymap.mode,
        keymap.lhs,
        keymap.rhs,
        { silent = keymap.silent == 1 }
      )
    end
    keymap_restore = {}
  end

  -- We need to override nvim-dap's default highlight groups, AFTER requiring nvim-dap for catppuccin.
  vim.api.nvim_set_hl(0, "DapStopped", { fg = colors.green })

  vim.fn.sign_define("DapBreakpoint", {
    text = icons.dap.breakpoint,
    texthl = "DapBreakpoint",
    linehl = "",
    numhl = "",
  })

  vim.fn.sign_define("DapBreakpointCondition", {
    text = icons.dap.breakpoint_condition,
    texthl = "DapBreakpoint",
    linehl = "",
    numhl = "",
  })

  vim.fn.sign_define("DapStopped", {
    text = icons.dap.stopped,
    texthl = "DapStopped",
    linehl = "",
    numhl = "",
  })

  vim.fn.sign_define("DapBreakpointRejected", {
    text = icons.dap.breakpoint_rejected,
    texthl = "DapBreakpoint",
    linehl = "",
    numhl = "",
  })

  vim.fn.sign_define("DapLogPoint", {
    text = icons.dap.log_point,
    texthl = "DapLogPoint",
    linehl = "",
    numhl = "",
  })
end
