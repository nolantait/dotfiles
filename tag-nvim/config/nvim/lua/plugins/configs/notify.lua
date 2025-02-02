-- DOCS: Provides better popup notifications

return function()
  local notify = require("notify")
  local colors = require("globals.colors")
  local icons = require("globals.icons")

  notify.setup({
    ---@usage Animation style one of { "fade", "slide", "fade_in_slide_out", "static" }
    stages = "fade",
    ---@usage Function called when a new window is opened, use for changing win settings/config
    on_open = function(win)
      -- vim.api.nvim_set_option_value("winblend", 0, { scope = "local", win = win })
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
    ---@usage Function called when a window is closed
    on_close = function() end,
    ---@usage timeout for notifications in ms, default 5000
    timeout = 2000,
    -- @usage User render fps value
    fps = 20,
    -- Render function for notifications. See notify-render()
    render = "default",
    ---@usage highlight behind the window for stages that change opacity
    background_colour = colors.darker_gray,
    ---@usage minimum width for notification windows
    minimum_width = 10,
    max_height = 50,
    ---@usage notifications with level lower than this would be ignored. [ERROR > WARN > INFO > DEBUG > TRACE]
    level = "TRACE",
    ---@usage Icons for the different levels
    icons = {
      ERROR = icons.error,
      WARN = icons.warn,
      INFO = icons.info,
      DEBUG = icons.bug,
      TRACE = icons.pencil,
    },
  })

  local buffered_messages = {
    "Client %d+ quit",
  }

  local banned_messages = {
    "No information available",
    "No code actions available",
    "method textDocument/codeAction is not supported by any of the servers registered for the current buffer",
    "no manual entry for",
    "No matching notification found to replace",
  }

  local message_notifications = {}

  -- Set our notifier as the default for neovim so it can work with other plugins
  vim.notify = function(message, level, options)
    options = options or {}

    for _, banned in ipairs(banned_messages) do
      if string.match(message, banned) then
        return
      end
    end

    for _, pattern in ipairs(buffered_messages) do
      if string.find(message, pattern) then
        if message_notifications[pattern] then
          options.replace = message_notifications[pattern]
        end

        options.on_close = function()
          message_notifications[pattern] = nil
        end

        message_notifications[pattern] = notify.notify(message, level, options)

        return
      end
    end

    vim.schedule(function()
      notify.notify(message, level, options)
    end)
  end
end
