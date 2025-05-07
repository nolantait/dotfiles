-- DOCS: Color hex codes and other colors are highlighted automatically

local colors = require("globals.colors")

return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = "LazyFile",
    opts = {
      render = "background",
      ---Set virtual symbol (requires render to be set to 'virtual')
      -- virtual_symbol = '■',
      ---Set virtual symbol suffix (defaults to '')
      -- virtual_symbol_prefix = '',
      ---Set virtual symbol suffix (defaults to ' ')
      -- virtual_symbol_suffix = ' ',
      ---Set virtual symbol position()
      ---@usage 'inline'|'eol'|'eow'
      ---inline mimics VS Code style
      ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
      ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
      -- virtual_symbol_position = 'inline',
      ---Highlight hex colors, e.g. '#FFFFFF'
      enable_hex = true,
      ---Highlight short hex colors e.g. '#fff'
      enable_short_hex = true,
      ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
      enable_rgb = true,
      ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
      enable_hsl = true,
      ---Highlight CSS variables, e.g. 'var(--testing-color)'
      enable_var_usage = true,
      ---Highlight named colors, e.g. 'green'
      enable_named_colors = true,
      ---Highlight tailwind colors, e.g. 'bg-blue-500'
      enable_tailwind = true,
      ---Set custom colors
      ---Label must be properly escaped with '%' to adhere to `string.gmatch`
      --- :help string.gmatch
      custom_colors = {
        { label = "base00", color = colors.black },
        { label = "base01", color = colors.darker_gray },
        { label = "base02", color = colors.dark_gray },
        { label = "base03", color = colors.gray },
        { label = "base04", color = colors.light_gray },
        { label = "base05", color = colors.lighter_gray },
        { label = "base06", color = colors.lightest_gray },
        { label = "base07", color = colors.white },
        { label = "base08", color = colors.red },
        { label = "base09", color = colors.orange },
        { label = "base0A", color = colors.yellow },
        { label = "base0B", color = colors.green },
        { label = "base0C", color = colors.cyan },
        { label = "base0D", color = colors.blue },
        { label = "base0E", color = colors.purple },
        { label = "base0F", color = colors.magenta },
      },
      -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
      exclude_filetypes = {},
      exclude_buftypes = {},
    },
  },
}
