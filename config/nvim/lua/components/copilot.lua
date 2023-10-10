-- Component for copilot statusline to show its status

local status_ok, api = prequire("copilot.api")
local M = { init = false }

local status = ""
local setup = function()
  if status_ok then
    api.register_status_notification_handler(function(data)
      -- customize your message however you want
      if data.status == "Normal" then
        status = ""
      elseif data.status == "InProgress" then
        status = ""
      else
        status = data.status or "Offline" -- might never actually be nil but just in case
      end
      status = " " .. status
    end)
  end
end

M.get_status = function()
  if not M.init then
    setup()
    M.init = true
  end
  return status
end

return M
