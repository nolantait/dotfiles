local tmux = require("utils.tmux")

local M = {
  pane_id = nil,
}

M.in_tmate = function()
  return tmux.in_tmate()
end

M.check_pane = function()
  if not M.pane_id then
    return false
  end

  local panes = tmux.list_panes()

  local found = false
  for _, pane in ipairs(panes) do
    if pane.id == M.pane_id then
      found = true
      break
    end
  end

  local exists = found

  if not exists then
    M.pane_id = nil
  end

  return exists
end

M.execute = function(cmd)
  M.check_pane()

  if not M.pane_id then
    M.create_pane()
  end

  tmux.send_keys(M.pane_id, { "-X", "cancel" }):wait()
  tmux.send_keys(M.pane_id, { "C-l" }):wait()
  tmux.send_keys(M.pane_id, { cmd, "C-m" }):wait()
end

M.create_pane = function()
  if M.pane_id then
    return M.pane_id
  end

  local pane_id = tmux.create_pane()

  M.pane_id = pane_id
end

return M
