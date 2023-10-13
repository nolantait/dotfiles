-- Provides gitsigns on the left side of the buffer, and as a source
-- to other plugins

return function()
  local gitsigns = require("gitsigns")

  gitsigns.setup {
    signs = {
      add = {
        hl = "GitSignsAdd",
        text = "▎",
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn"
      },
      change = {
        hl = "GitSignsChange",
        text = "▎",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn"
      },
      delete = {
        hl = "GitSignsDelete",
        text = "▁",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn"
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = "▔",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn"
      },
      changedelete = {
        hl = "GitSignsChange",
        text = "▎",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn"
      },
    },
    attach_to_untracked = true,
    current_line_blame = false,   -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",   -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
      relative_time = false,
    },
    diff_opts = { internal = true },
    linehl = false,   -- Toggle with `:Gitsigns toggle_linehl`
    max_file_length = 40000,
    numhl = true,     -- Toggle with `:Gitsigns toggle_numhl`
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    sign_priority = 6,
    signcolumn = true,        -- Toggle with `:Gitsigns toggle_signs`
    status_formatter = nil,   -- Use default
    update_debounce = 100,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    word_diff = false,   -- Toggle with `:Gitsigns toggle_word_diff`
    yadm = {
      enable = false,
    },
  }
end
