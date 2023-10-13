local ok, notify = prequire("notify")
if not ok then
  return
end

if notify then
  local colors = require("user.colors")

  notify.setup({
    ---@usage Animation style one of { "fade", "slide", "fade_in_slide_out", "static" }
    stages = "fade_in_slide_out",
    ---@usage Function called when a new window is opened, use for changing win settings/config
    on_open = function(win)
      vim.api.nvim_set_option_value("winblend", 0, { scope = "local", win = win })
      vim.api.nvim_win_set_config(win, { zindex = 90 })
    end,
    ---@usage Function called when a window is closed
    on_close = nil,
    ---@usage timeout for notifications in ms, default 5000
    timeout = 2000,
    -- @usage User render fps value
    fps = 60,
    -- Render function for notifications. See notify-render()
    render = "default",
    ---@usage highlight behind the window for stages that change opacity
    background_colour = colors.darker_gray,
    ---@usage minimum width for notification windows
    minimum_width = 25,
    ---@usage notifications with level lower than this would be ignored. [ERROR > WARN > INFO > DEBUG > TRACE]
    level = "TRACE",
    ---@usage Icons for the different levels
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "󰏫",
    },
  })

  vim.notify = notify
end
