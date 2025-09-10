-- DOCS: Decorated scrollbar on the right

return {
  {
    "lewis6991/satellite.nvim",
    -- Disabled until they fix deleting the current buffer
    enabled = false,
    lazy = false,
    opts = {
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
    },
  },
}
