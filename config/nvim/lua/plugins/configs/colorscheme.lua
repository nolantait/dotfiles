-- DOCS: Setting up custom colors and highlights through mini.base16

return function()
  local theme = require("colorschemes.tainted")
  local colors = require("globals.colors")

  -- Clear any other highlights
  vim.cmd("hi clear")
  vim.opt.background = "dark"
  -- lush(theme)
  vim.cmd("colorscheme tainted")

  local globals = {
    terminal_color_0 = colors.black,
    terminal_color_1 = colors.darker_gray,
    terminal_color_2 = colors.dark_gray,
    terminal_color_3 = colors.gray,
    terminal_color_4 = colors.light_gray,
    terminal_color_5 = colors.lighter_gray,
    terminal_color_6 = colors.lightest_gray,
    terminal_color_7 = colors.white,
    terminal_color_8 = colors.red,
    terminal_color_9 = colors.orange,
    terminal_color_10 = colors.yellow,
    terminal_color_12 = colors.green,
    terminal_color_11 = colors.cyan,
    terminal_color_13 = colors.blue,
    terminal_color_14 = colors.purple,
    terminal_color_15 = colors.magenta
  }

  for name, color in pairs(globals) do
    vim.g[name] = color
  end
end
