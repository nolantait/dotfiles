-- DOCS: Quality of life improvements

return function()
  local snacks = require("snacks")
  local icons = require("globals.icons")

  snacks.setup({
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
    zen = { enabled = true }
  })
end
