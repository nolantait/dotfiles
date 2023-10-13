-- Better UI for neovim, used by other plugins

return function()
  local dressing = require("dressing")

  dressing.setup({
    input = {
      default_prompt = "➤ ",
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
