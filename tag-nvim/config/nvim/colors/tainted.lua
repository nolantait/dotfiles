local colors = require("globals.colors")

-- Reset highlights
vim.cmd.highlight("clear")
if vim.fn.exists("syntax_on") then
  vim.cmd.syntax("reset")
end

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
  terminal_color_15 = colors.magenta,
}

for name, color in pairs(globals) do
  vim.g[name] = color
end

-- By setting our module to nil, we clear lua"s cache,
-- which means the require ahead will *always* occur.
--
-- This isn"t strictly required but it can be a useful trick if you are
-- incrementally editing your config a lot and want to be sure your themes
-- changes are being picked up without restarting neovim.
--
-- Note if you"re working in on your theme and have :Lushify"d the buffer,
-- your changes will be applied with our without the following line.
--
-- The performance impact of this call can be measured in the hundreds of
-- *nanoseconds* and such could be considered "production safe".
package.loaded["colorscheme"] = nil
local theme = require("colorscheme")
theme.setup()

-- include our theme file and pass it to lush to apply
require("lush")(theme.theme)

-- You probably always want to set this in your vim file
vim.g.colors_name = "tainted"
vim.opt.termguicolors = true
vim.opt.background = "dark"
