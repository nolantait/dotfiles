-- DOCS: Sets up Debugger Adapter Protocol

local colors = require("globals.colors")
local icons = require("globals.icons")

local config = function()
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

return {
  {
    -- Debug Adapter Protocol setup for interactive debugging
    "mfussenegger/nvim-dap",
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    config = config,
    keys = {
      {
        "<leader>db",
        mode = { "n", "v" },
        desc = "Toggle Breakpoint",
        function()
          require("dap").toggle_breakpoint()
        end,
      },
      {
        "<leader>dc",
        mode = { "n", "v" },
        desc = "Continue",
        function()
          require("dap").continue()
        end,
      },
      {
        "<leader>di",
        mode = { "n", "v" },
        desc = "Step Into",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<leader>do",
        mode = { "n", "v" },
        desc = "Step Over",
        function()
          require("dap").step_over()
        end,
      },
      {
        "<leader>du",
        mode = { "n", "v" },
        desc = "Step Out",
        function()
          require("dap").step_out()
        end,
      },
      {
        "<leader>dr",
        mode = { "n", "v" },
        desc = "Repl",
        function()
          require("dap").repl.toggle()
        end,
      },
      {
        "<leader>dt",
        mode = { "n", "v" },
        desc = "Terminate",
        function()
          require("dap").terminate()
        end,
      },
      {
        "<leader>dl",
        mode = { "n", "v" },
        desc = "Log",
        function()
          require("dap").run_last()
        end,
      },
      {
        "<leader>de",
        mode = { "n", "v" },
        desc = "Evaluate",
        function()
          require("dap.ui.widgets").hover()
        end,
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    opts = { virt_text_pos = "eol" },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    opts = {
      force_buffers = true,
      icons = {
        expanded = icons.open,
        collapsed = icons.collapsed,
        current_frame = icons.target,
      },
      mappings = {
        -- Use a table to apply multiple mappings
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            -- Provide as ID strings or tables with "id" and "size" keys
            {
              id = "scopes",
              size = 0.5, -- Can be float or integer > 1
            },
            { id = "stacks", size = 0.3 },
            { id = "watches", size = 0.1 },
            { id = "breakpoints", size = 0.1 },
          },
          size = 0.25,
          position = "right",
        },
        {
          elements = {
            { id = "console", size = 0.25 },
            { id = "repl", size = 0.75 },
          },
          position = "bottom",
          size = 0.25,
        },
      },
      controls = {
        enabled = true,
        -- Display controls in this session
        element = "repl",
        icons = {
          pause = icons.pause,
          play = icons.play,
          step_into = icons.dap.step_into,
          step_over = icons.dap.step_over,
          step_out = icons.dap.step_out,
          step_back = icons.dap.step_back,
          run_last = icons.dap.run_last,
          terminate = icons.dap.terminate,
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      render = { indent = 1, max_value_lines = 85 },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    opts = { virt_text_pos = "eol" },
  },
}
