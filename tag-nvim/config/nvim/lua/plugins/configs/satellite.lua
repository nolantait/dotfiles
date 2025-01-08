-- DOCS: Decorated scrollbar on the right

return function()
  local satellite = require("satellite")

  satellite.setup({
    current_only = false,
    winblend = 0,
    zindex = 40,
    excluded_filetypes = {},
    width = 1,
    handlers = {
      cursor = {
        enable = true,
        symbols = { "█" },
      },
      search = {
        enable = true,
      },
      diagnostic = {
        enable = true,
        signs = { "-", "=", "≡" },
        min_severity = vim.diagnostic.severity.HINT,
      },
      gitsigns = {
        enable = true,
        signs = { -- can only be a single character (multibyte is okay)
          add = "▎",
          change = "▎",
          delete = "▁",
        },
      },
      marks = {
        enable = false,
        key = "m",
        show_builtins = false, -- shows the builtin marks like [ ] < >
      },
    },
  })
end
