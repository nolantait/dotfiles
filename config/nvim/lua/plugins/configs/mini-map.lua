return function()
  local mini_map = require("mini.map")
  local icons = require("globals.icons")

  mini_map.setup({
    -- Highlight integrations (none by default)
    integrations = {
      mini_map.gen_integration.builtin_search(),
      mini_map.gen_integration.gitsigns(),
      mini_map.gen_integration.diagnostic(),
    },

    -- Symbols used to display data
    symbols = {
      -- Encode symbols. See `:h MiniMap.config` for specification and
      -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
      -- Default: solid blocks with 3x2 resolution.
      encode = mini_map.gen_encode_symbols.dot("4x2"),

      -- Scrollbar parts for view and line. Use empty string to disable any.
      scroll_line = icons.circle,
      scroll_view = '┃',
    },

    -- Window options (has a z-index of 10, no way to change currently)
    window = {
      -- Whether window is focusable in normal way (with `wincmd` or mouse)
      focusable = false,

      -- Side to stick ('left' or 'right')
      side = 'right',

      -- Whether to show count of multiple integration highlights
      show_integration_count = false,

      -- Total width
      width = 10,

      -- Value of 'winblend' option
      winblend = 0,
    },
  })

  vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("_mini_map", { clear = true }),
    pattern = "*",
    desc = "Swaps scrollbar for mini map if file is bigger than window",
    callback = function()
      -- Get the number of lines in the buffer
      local total_lines = vim.fn.line('$')

      -- Get the number of lines that can be displayed in the current window
      local window_height = vim.fn.winheight(0)

      local show_map = total_lines > window_height

      local bufnr = vim.api.nvim_get_current_buf()

      local buffer_name = vim.fn.expand('%:t')
      local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })

      if buftype == "nofile" then
        show_map = false
      end

      -- Check if the total lines in the buffer exceed the window height
      if show_map then
        vim.cmd("lua MiniMap.open()")
        vim.cmd("ScrollbarHide")
      else
        vim.cmd("lua MiniMap.close()")
        vim.cmd("ScrollbarShow")
      end
    end
  })
end
