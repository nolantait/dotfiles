local ok, base16 = prequire("base16-colorscheme")
if not ok then
  return
end

local colors = require("user.colors")

if base16 then
  base16.setup({
    base00 = colors.black,
    base01 = colors.darker_gray,
    base02 = colors.dark_gray,
    base03 = colors.gray,
    base04 = colors.light_gray,
    base05 = colors.lighter_gray,
    base06 = colors.lightest_gray,
    base07 = colors.white,
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
  set_hl(0, "AlphaHeader", { fg = colors.blue, default = true })

  set_hl(0, "MatchParen", { fg = colors.white, bg = colors.light_gray, bold = true })
end
