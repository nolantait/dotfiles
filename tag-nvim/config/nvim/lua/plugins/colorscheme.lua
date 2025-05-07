-- DOCS: Loads the tainted colorscheme

local settings = require("globals.settings")

local config = function()
  local colors = require("globals.colors")

  vim.cmd("colorscheme tainted")

  local globals = {
    terminal_color_0 = colors.black,
    terminal_color_1 = colors.red,
    terminal_color_2 = colors.green,
    terminal_color_3 = colors.yellow,
    terminal_color_4 = colors.blue,
    terminal_color_5 = colors.magenta,
    terminal_color_6 = colors.cyan,
    terminal_color_7 = colors.white,
    terminal_color_8 = colors.red,
    terminal_color_9 = colors.green,
    terminal_color_10 = colors.yellow,
    terminal_color_12 = colors.blue,
    terminal_color_11 = colors.magenta,
    terminal_color_13 = colors.cyan,
    terminal_color_14 = colors.purple,
    terminal_color_15 = colors.lighter_gray,
  }

  for name, color in pairs(globals) do
    vim.g[name] = color
  end
end

return {
  {
    dir = settings.vim_path .. "/custom_plugins/colorscheme.nvim",
    config = config,
    priority = 1000,
    lazy = false,
  },
  {
    "rktjmp/lush.nvim",
    lazy = false,
  },
}
