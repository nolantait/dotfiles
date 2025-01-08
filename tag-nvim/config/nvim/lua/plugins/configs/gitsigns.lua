-- DOCS: Provides gitsigns on the left side of the buffer, and as a source
-- to other plugins

return function()
  local gitsigns = require("gitsigns")

  gitsigns.setup({
    signs = {
      add = {
        text = "▎",
      },
      change = {
        text = "▎",
      },
      delete = {
        text = "▁",
      },
      topdelete = {
        text = "▔",
      },
      changedelete = {
        text = "▎",
      },
    },
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = false,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    diff_opts = { internal = true },
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    max_file_length = 40000,
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    sign_priority = 6,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    status_formatter = nil, -- Use default
    update_debounce = 100,
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  })
end
