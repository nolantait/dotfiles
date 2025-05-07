-- DOCS: Quality of life improvements

local icons = require("globals.icons")

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      {
        "<leader>un",
        mode = { "n", "v" },
        desc = "Dismiss all notifications",
        function()
          require("snacks").notifier.hide()
        end,
      },
      {
        "<leader>uh",
        mode = { "n", "v" },
        desc = "Show notification history",
        function()
          require("snacks").notifier.show_history()
        end,
      },
      {
        "<leader>zm",
        mode = { "n", "v" },
        desc = "Toggle zen mode",
        function()
          require("snacks").zen()
        end,
      },
      {
        "]]",
        mode = { "n", "v" },
        desc = "Go to next reference",
        function()
          require("snacks").words.jump(vim.v.count1)
        end,
      },
      {
        "[[",
        mode = { "n", "v" },
        desc = "Go to previous reference",
        function()
          require("snacks").words.jump(-vim.v.count1)
        end,
      },
      {
        "<leader>q",
        mode = { "n", "v" },
        desc = "Close buffer",
        function()
          require("snacks").bufdelete.delete(0)
        end,
      },
      {
        "<leader>Q",
        mode = { "n", "v" },
        desc = "Close all other buffers",
        function()
          require("snacks").bufdelete.other()
        end,
      },
    },
    init = function()
      vim.ui.input = require("snacks").input
    end,
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      animate = {
        duration = 20,
        easing = "linear",
        fps = 60,
      },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = {
        indent = {
          enabled = true,
          char = "╎",
          hl = "SnacksIndent",
        },
        scope = {
          enabled = true,
          char = "╎",
          priority = 200,
          hl = "SnacksIndentScope",
        },
        chunk = {
          enabled = true,
          char = {
            arrow = ">",
            corner_bottom = "╰",
            corner_top = "╭",
            horizontal = "─",
            vertical = "╎",
          },
        },
      },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
        width = { min = 10, max = 50 },
        height = { min = 1, max = 50 },
        padding = true,
        sort = { "level", "added" },
        level = vim.log.levels.INFO,
        refresh = 50, -- refresh at most every 50ms
        style = "fancy",
        icons = {
          error = icons.error,
          warn = icons.warn,
          info = icons.info,
          debug = icons.debug,
          trace = icons.trace,
        },
      },
      picker = { enabled = false },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true },
    },
  },
}
