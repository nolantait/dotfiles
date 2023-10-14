-- Component for copilot statusline to show its status

return function()
  local ok, api = pcall(require, "copilot.api")

  local status = ""
  if ok and api then
    api.register_status_notification_handler(function(data)
      -- customize your message however you want
      if data.status == "Normal" then
        status = ""
      elseif data.status == "InProgress" then
        status = ""
      else
        status = data.status or "Offline" -- might never actually be nil but just in case
      end
      status = "" .. " ".. status
    end)
  end

  return status
end
