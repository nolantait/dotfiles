-- DOCS: Buffers at the very top of the screen

local icons = require("globals.icons")

-- Optionally use bufdelete to close buffers with fallback
local close_command = function(bufnum)
  local ok, bufremove = prequire("mini.bufremove")

  if ok and bufremove then
    bufremove.delete(bufnum, true)
  else
    vim.cmd.bdelete({
      args = { bufnum },
      bang = true,
    })
  end
end

return {
  {
    -- Buffer tabs at the top of screen
    "akinsho/bufferline.nvim",
    event = "LazyFile",
    opts = {
      options = {
        always_show_bufferline = true,
        auto_toggle_bufferline = false,
        buffer_close_icon = icons.cross,
        close_command = close_command, -- can be a string | function, see "Mouse actions"
        close_icon = icons.cross,
        color_icons = true,
        diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        enforce_regular_tabs = false,
        hover = {
          enabled = true,
          delay = 50,
          reveal = { "close" },
        },
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        left_trunc_marker = icons.arrow_left,
        max_name_length = 14,
        max_prefix_length = 8, -- prefix used when a buffer is de-duplicated
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        mode = "buffers",
        modified_icon = icons.circle,
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            padding = 1,
            text_align = "center",
          },
          {
            filetype = "neo-tree",
            text = "File Explorer",
            padding = 1,
            text_align = "center",
          },
        },
        right_mouse_command = close_command, -- can be a string | function, see "Mouse actions"
        right_trunc_marker = icons.arrow_right,
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_tab_indicators = false,
        sort_by = "insert_at_end",
        tab_size = 20,
        themable = true,
      },
    },
  },
}
