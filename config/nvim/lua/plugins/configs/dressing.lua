-- Better UI for neovim, used by other plugins

return function()
  local dressing = require("dressing")
  local icons = require("globals.icons")

  dressing.setup({
    input = {
      default_prompt = icons.play .. " ",
      win_options = {
        winhighlight = "Normal:Normal,NormalNC:Normal"
      },
    },
    select = {
      backend = { "telescope", "builtin" },
      builtin = {
        win_options = {
          winhighlight = "Normal:Normal,NormalNC:Normal"
        }
      },
    },
  })
end
