local ok, bufferline = prequire("bufferline")
if not ok then
  return
end

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
      numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      close_command = close_command, -- can be a string | function, see "Mouse actions"
      right_mouse_command = close_command, -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
      indicator = {
        style = "icon",
        icon = "▎"
      },
      buffer_close_icon = "󱎘",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 8, -- prefix used when a buffer is de-duplicated
      tab_size = 20,
      diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
      diagnostics_update_in_insert = false,
      offsets = {
        { filetype = "NvimTree", text = "", padding = 1 },
        { filetype = "neo-tree", text = "", padding = 1 }
      },
      separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
      enforce_regular_tabs = true,
      always_show_bufferline = true,
    },
    highlights = {
      fill = {
        bg = { attribute = "bg", highlight = "Normal" },
      },
      buffer_selected = { bold = true },
      diagnostic_selected = { bold = true },
      info_selected = { bold = true },
      info_diagnostic_selected = { bold = true },
      warning_selected = { bold = true },
      warning_diagnostic_selected = { bold = true },
      error_selected = { bold = true },
      error_diagnostic_selected = { bold = true },
    },
  }
end
