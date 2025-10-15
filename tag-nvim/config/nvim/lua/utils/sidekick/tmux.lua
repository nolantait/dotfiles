local M = {}

--- Finds the Sidekick session named "aider"
---@return table|nil The Sidekick session object or nil if not found
local find_session = function()
  local Session = require("sidekick.cli.session")
  local sessions = Session.sessions()

  for _, session in ipairs(sessions) do
    if session.tool.name == "aider" then
      return session
    end
  end
end

-- Get all loaded and listed buffer filenames
---@return string[]
local get_buffer_filenames = function()
  local filenames = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if
      vim.api.nvim_buf_is_loaded(buf)
      and vim.api.nvim_get_option_value("buflisted", { buf = buf })
    then
      local filename = vim.api.nvim_buf_get_name(buf)
      if filename ~= "" then
        table.insert(filenames, filename)
      end
    end
  end

  return filenames
end

-- Add all loaded and listed buffers to the aider tmux session
M.add_files = function()
  local session = find_session()

  if not session then
    vim.notify("No Sidekick aider tmux session found", vim.log.levels.WARN)
    return
  end

  local filenames = get_buffer_filenames()

  for _, filename in ipairs(filenames) do
    session:send("/add " .. filename)
    session:submit()
  end
end

return M
