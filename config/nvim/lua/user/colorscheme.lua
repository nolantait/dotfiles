local ok, base16 = prequire("base16-colorscheme")
if not ok then
  return
end

if base16 then
  -- Start flavours
  -- Base16 OneDark
  -- Author: Lalit Magant (http://github.com/tilal6991)
  -- Sets up the theme for base16-vim

  local colors = {
    black = '#282c34',
    darker_gray = '#353b45',
    dark_gray = '#3e4451',
    gray = '#545862',
    light_gray = '#565c64',
    lighter_gray = '#abb2bf',
    lightest_gray = '#b6bdca',
    white = '#c8ccd4',
    red = '#e06c75',
    orange = '#d19a66',
    yellow = '#e5c07b',
    green = '#98c379',
    cyan = '#56b6c2',
    blue = '#61afef',
    purple = '#c678dd',
    magenta = '#be5046',
  }
  -- End flavours

  base16.setup({
    base00 = colors.black,
    base01 = colors.darker_gray,
    base02 = colors.dark_gray,
    base03 = colors.gray,
    base04 = colors.light_gray,
    base05 = colors.lighter_gray,
    base06 = colors.lightest_gray,
    base07 = colors.light,
    base08 = colors.red,
    base09 = colors.orange,
    base0A = colors.yellow,
    base0B = colors.green,
    base0C = colors.cyan,
    base0D = colors.blue,
    base0E = colors.purple,
    base0F = colors.magenta,
  })

  local set_hl = vim.api.nvim_set_hl

  set_hl(0, "AlphaFooter", { fg = colors.yellow, default = true })
  set_hl(0, "MatchParen", { fg = colors.white, bg = colors.light_gray, bold = true })
end


