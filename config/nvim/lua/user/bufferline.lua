local ok, bufferline = prequire("bufferline")
if not ok then
  return
end

local colors = require("user.colors")

local hl_colors = {
  unselected = {
    bg = colors.black,
    text = colors.gray,
  },
  selected = {
    bg = colors.dark_gray,
    text = colors.white,
    indicator = colors.orange
  }
}

local highlights = {
  -- buffers
  background = { bg = hl_colors.unselected.bg },
  buffer_visible = { fg = hl_colors.unselected.text, bg = hl_colors.unselected.bg },
  buffer_selected = { fg = hl_colors.selected.text, bg = hl_colors.selected.bg, bold = true, italic = true },  -- current
  indicator_selected = { fg = hl_colors.unselected.bg, bg = hl_colors.selected.indicator },
  -- separators
  separator = { fg = hl_colors.unselected.bg, bg = hl_colors.unselected.bg },
  -- close buttons
  close_button = { fg = hl_colors.unselected.text, bg = hl_colors.unselected.bg },
  close_button_visible = { fg = hl_colors.unselected.text, bg = hl_colors.unselected.bg },
  close_button_selected = { fg = colors.red, bg = hl_colors.selected.bg },
  -- Empty fill
  fill = { bg = hl_colors.unselected.bg },
  -- Errors
  error = { fg = colors.red, bg = hl_colors.unselected.bg },
  error_visible = { fg = colors.red, bg = hl_colors.unselected.bg },
  error_selected = { fg = colors.red, bg = hl_colors.selected.bg, bold = true, italic = true },
  error_diagnostic = { fg = colors.red, bg = hl_colors.unselected.bg },
  error_diagnostic_visible = { fg = colors.red, bg = hl_colors.unselected.bg },
  error_diagnostic_selected = { fg = colors.red, bg = hl_colors.selected.bg },
  -- Warnings
  warning = { fg = colors.yellow, bg = hl_colors.unselected.bg },
  warning_visible = { fg = colors.yellow, bg = hl_colors.unselected.bg },
  warning_selected = { fg = colors.yellow, bg = hl_colors.selected.bg, bold = true, italic = true },
  warning_diagnostic = { fg = colors.yellow, bg = hl_colors.unselected.bg },
  warning_diagnostic_visible = { fg = colors.yellow, bg = hl_colors.unselected.bg },
  warning_diagnostic_selected = { fg = colors.yellow, bg = hl_colors.selected.bg },
  -- Infos
  info = { fg = colors.cyan, bg = hl_colors.unselected.bg },
  info_visible = { fg = colors.cyan, bg = hl_colors.unselected.bg },
  info_selected = { fg = colors.cyan, bg = hl_colors.selected.bg, bold = true, italic = true },
  info_diagnostic = { fg = colors.cyan, bg = hl_colors.unselected.bg },
  info_diagnostic_visible = { fg = colors.cyan, bg = hl_colors.unselected.bg },
  info_diagnostic_selected = { fg = colors.cyan, bg = hl_colors.selected.bg },
  -- Hint
  hint = { fg = colors.teal, bg = hl_colors.unselected.bg },
  hint_visible = { fg = colors.teal, bg = hl_colors.unselected.bg },
  hint_selected = { fg = colors.teal, bg = hl_colors.selected.bg, bold = true, italic = true },
  hint_diagnostic = { fg = colors.teal, bg = hl_colors.unselected.bg },
  hint_diagnostic_visible = { fg = colors.teal, bg = hl_colors.unselected.bg },
  hint_diagnostic_selected = { fg = colors.teal, bg = hl_colors.selected.bg },
  -- Diagnostics
  diagnostic = { fg = colors.gray, bg = hl_colors.unselected.bg },
  diagnostic_visible = { fg = colors.gray, bg = hl_colors.unselected.bg },
  diagnostic_selected = { fg = colors.gray, bg = hl_colors.selected.bg, bold = true, italic = true },
  -- Modified
  modified = { fg = colors.orange, bg = hl_colors.unselected.bg },
  modified_selected = { fg = colors.orange, bg = hl_colors.selected.bg },
}

-- Optionally use bufdelete to close buffers with fallback
local close_command = function(bufnum)
  local _ok, bufdelete = prequire("bufdelete")

  if _ok and bufdelete then
    bufdelete.bufdelete(bufnum, true)
  else
    vim.cmd.bdelete { args = { bufnum }, bang = true }
  end
end

if bufferline then
  bufferline.setup {
    options = {
      always_show_bufferline = true,
      buffer_close_icon = "󱎘",
      close_command = close_command, -- can be a string | function, see "Mouse actions"
      close_icon = "",
      color_icons = true,
      diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
      diagnostics_update_in_insert = false,
      enforce_regular_tabs = false,
      indicator = {
        style = "icon",
        icon = "▎"
      },
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      left_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 8,      -- prefix used when a buffer is de-duplicated
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
      modified_icon = "●",
      numbers = "none",           -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          padding = 1,
          text_align = "center"
        },
        {
          filetype = "neo-tree",
          text = "File Explorer",
          padding = 1,
          text_align = "center"
        }
      },
      right_mouse_command = close_command, -- can be a string | function, see "Mouse actions"
      right_trunc_marker = "",
      separator_style = "thin",            -- | "thick" | "thin" | { 'any', 'any' },
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_tab_indicators = true,
      tab_size = 20,
    },
    highlights = highlights
  }
end
