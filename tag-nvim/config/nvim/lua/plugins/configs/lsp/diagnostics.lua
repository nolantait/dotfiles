local M = {}

function M.setup()
  local icons = require("globals.icons")
  local severity = vim.diagnostic.severity

  -- Global config for diagnostics
  vim.diagnostic.config({
    -- virtual_lines = { current_line = true },
    virtual_text = true,
    inlay_hints = {
      enabled = true,
      exclude = {},
    },
    signs = {
      text = {
        [severity.ERROR] = icons.error,
        [severity.WARN] = icons.warn,
        [severity.HINT] = icons.hint,
        [severity.INFO] = icons.info,
      },
    },
    severity_sort = true,
    update_in_insert = false,
    underline = true,
    float = {
      focused = false,
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "if_many",
    },
  })
end

return M
