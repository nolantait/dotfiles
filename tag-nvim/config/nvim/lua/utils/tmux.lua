---@class tmux.Pane
---@field id string The pane ID (e.g., "%1")
---@field active boolean Whether the pane is currently active
---@field command string The current command running in the pane

local M = {}

local function env(name)
  return vim.fn.getenv(name) ~= vim.NIL and vim.fn.getenv(name) or nil
end

-- Checks if the current environment is a tmate session
---@return boolean
M.in_tmate = function()
  -- prefer TMUX content (e.g. "/private/tmp/tmate-501/...") and fallback to TMATE_* vars
  local tmux_env = vim.env.TMUX or ""
  if string.find(tmux_env, "tmate", 1, true) then
    return true
  end
  if env("TMATE") or env("TMATE_SESSION") or env("TMATE_SOCK") then
    return true
  end
  return false
end

-- Lists all tmux panes with their id, active status, and current command
---@return tmux.Pane[]
M.list_panes = function()
  local list = vim
    .system({
      M.binary(),
      "list-panes",
      "-F",
      "'#{pane_id} #{pane_active} #{pane_current_command}'",
    })
    :wait()

  local panes = {}
  local lines = vim.split(list.stdout, "\n", { trimempty = true })
  for _, line in ipairs(lines) do
    local pane_id, pane_active, pane_current_command =
      line:match("'(%%[%d]+) (%d) (.+)'")

    if pane_id and pane_active and pane_current_command then
      table.insert(panes, {
        id = pane_id,
        active = pane_active == "1",
        command = pane_current_command,
      })
    end
  end

  return panes
end

---@return string The tmux binary name ("tmux" or "tmate")
M.binary = function()
  return M.in_tmate() and "tmate" or "tmux"
end

-- Sends keys to a specific tmux pane
---@param pane_id string The ID of the pane to check (e.g., "%1")
---@param command string|nil|table Optional command to match against the pane's
---@return vim.SystemObj
M.send_keys = function(pane_id, command)
  local cmd = { M.binary(), "send-keys", "-t", pane_id }

  if command then
    if type(command) == "table" then
      for _, c in ipairs(command) do
        table.insert(cmd, c)
      end
    else
      table.insert(cmd, command)
    end
  end

  return vim.system(cmd)
end

-- Creates a new tmux pane running in the current working directory
---@return string The ID of the newly created pane (e.g., "%2")
M.create_pane = function()
  local pane = vim
    .system({
      M.binary(),
      "split-window",
      "-P", -- Print the pane ID of the newly created pane
      "-F",
      "'#{pane_id}'", -- Format to only return the pane ID
      "-l", -- Create the new pane as a horizontal split
      "20",
    })
    :wait()

  local pane_id = pane.stdout:match("'(%%[%d]+)'")
  M.pane_id = pane_id

  return pane_id
end

return M
