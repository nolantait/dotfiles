-- DOCS: Setting up custom colors and highlights through mini.base16

return function()
  local base16 = require("mini.base16")
  local colors = require("globals.colors")

  base16.setup({
    palette = {
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
    },
    use_cterm = true,
    plugins = { default = true }
  })

  local set_hl = vim.api.nvim_set_hl

  set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

  set_hl(0, "Structure", { fg = colors.yellow })
  set_hl(0, "SpecialChar", { fg = colors.purple })

  set_hl(0, "LineNr", { bg = colors.black, fg = colors.light_gray })
  set_hl(0, "LineNrAbove", { bg = colors.black, fg = colors.light_gray })
  set_hl(0, "LineNrBelow", { bg = colors.black, fg = colors.light_gray })
  set_hl(0, "SignColumn", { bg = colors.black })

  set_hl(0, "NormalFloat", { bg = colors.black })
  set_hl(0, "FloatBorder", { fg = colors.light_gray })
  set_hl(0, "FloatBorderCmp", { fg = colors.light_gray })
  set_hl(0, "TelescopeBorder", { fg = colors.lighter_gray })
  set_hl(0, "FloatBorderDocs", { fg = colors.blue })

  set_hl(0, "MiniIndentscopeSymbol", { fg = colors.lighter_gray })
  set_hl(0, "MiniMapSymbolLine", { fg = colors.white })
  set_hl(0, "MiniMapSymbolView", { fg = colors.light_gray })

  set_hl(0, "CmpPmenu", { bg = colors.black })

  set_hl(0, "AlphaFooter", { fg = colors.yellow })
  set_hl(0, "AlphaHeader", { fg = colors.blue })

  set_hl(0, "MatchParen", { fg = colors.lightest_gray, bg = colors.light_gray, bold = true })

  set_hl(0, "GitSignsAdd", { fg = colors.green })
  set_hl(0, "GitSignsAddNr", { fg = colors.green })
  set_hl(0, "GitSignsChange", { fg = colors.orange })
  set_hl(0, "GitSignsChangeNr", { fg = colors.orange })
  set_hl(0, "GitSignsDelete", { fg = colors.red })
  set_hl(0, "GitSignsDeleteNr", { fg = colors.red })

  -- TODO: Figure out how to set this better
  set_hl(0, "BufferLineFill", { bg = "#16181c", fg = "#16181c" })
end
