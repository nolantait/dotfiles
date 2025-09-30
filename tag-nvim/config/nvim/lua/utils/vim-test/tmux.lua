local M = {
  pane_variable = "vim_test_pane",
}

local private = {
  pane_id = nil,
}

local function env(name)
  return vim.fn.getenv(name) ~= vim.NIL and vim.fn.getenv(name) or nil
end

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

M.check_pane = function()
  if not private.pane_id then
    return false
  end

  local check =
    os.execute("tmux list-panes -F '#{pane_id}' | grep -q " .. private.pane_id)
  local exists = check == 0

  if not exists then
    private.pane_id = nil
  end

  return exists
end

M.execute = function(cmd)
  M.check_pane()

  if not private.pane_id then
    M.create_pane()
  end

  vim
    .system({ "tmux", "send-keys", "-t", private.pane_id, "-X", "cancel" })
    :wait()
  -- Clear the pane
  vim.system({ "tmux", "send-keys", "-t", private.pane_id, "C-l" }):wait()
  -- Send the testing command
  vim
    .system({
      "tmux",
      "send-keys",
      "-t",
      private.pane_id,
      cmd,
      "C-m",
    })
    :wait()
end

M.create_pane = function()
  if private.pane_id then
    return private.pane_id
  end

  local pane_id = vim
    .system({
      "tmux",
      "split-window",
      "-P",
      "-F",
      "#{pane_id}",
      "-v",
      "-l",
      "20",
    })
    :wait().stdout
    :gsub("%s+$", "")

  private.pane_id = pane_id
end

return M
