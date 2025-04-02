local M = {}

local function setup_virtual_text_toggle()
  local text_config = nil
  local lines_config = nil

  vim.api.nvim_create_autocmd({ "CursorMoved", "DiagnosticChanged" }, {
    group = vim.api.nvim_create_augroup("tainted/virtlines", {}),
    callback = function()
      -- Cache the original virtual lines config if not already cached
      if lines_config == nil then
        lines_config = vim.diagnostic.config().virtual_lines
      end

      -- If virtual_lines.current_line is disabled, restore virtual text and exit
      if not (lines_config and lines_config.current_line) then
        if text_config then
          vim.diagnostic.config({ virtual_text = text_config })
          text_config = nil
        end
        return
      end

      -- Cache the original virtual text config if not already cached
      if text_config == nil then
        text_config = vim.diagnostic.config().virtual_text
      end

      -- Get current line number (0-indexed)
      local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1

      -- Check if there are diagnostics on the current line
      local has_diagnostics =
        not vim.tbl_isempty(vim.diagnostic.get(0, { lnum = current_line }))

      -- Toggle virtual text based on presence of diagnostics
      if has_diagnostics then
        -- Hide virtual text when there are diagnostics (and thus virtual lines)
        vim.diagnostic.config({ virtual_text = false })
      else
        -- Show virtual text when there are no diagnostics
        vim.diagnostic.config({ virtual_text = text_config })
      end
    end,
  })
end

local function setup_diagnostic_config()
  local icons = require("globals.icons")
  local severity = vim.diagnostic.severity

  vim.diagnostic.config({
    virtual_lines = { current_line = true },
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

function M.setup()
  setup_diagnostic_config()
  setup_virtual_text_toggle()
end

return M
