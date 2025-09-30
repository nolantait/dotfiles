local function env(name)
  return vim.fn.getenv(name) ~= vim.NIL and vim.fn.getenv(name) or nil
end

local function in_tmate()
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

return {
  {
    "vim-test/vim-test",
    init = function()
      vim.g["test#custom_strategies"] = {
        tmux = function(cmd)
          local pane_var = "vim_test_pane"
          local pane_id = vim.g[pane_var]

          local function shell(cmd_str)
            local handle = io.popen(cmd_str)
            local result = handle:read("*a")
            handle:close()

            return result:gsub("%s+$", "")
          end

          -- Spawn the pane at fixed height if it doesn't exist
          if not pane_id or pane_id == "" then
            pane_id = shell("tmux split-window -P -F '#{pane_id}' -v -l 20")
            vim.g[pane_var] = pane_id
          else
            local exists = os.execute(
              "tmux list-panes -F '#{pane_id}' | grep -q " .. pane_id
            )
            if exists ~= 0 then
              vim.g[pane_var] = nil
              return vim.g["test#custom_strategies"].tmux(cmd)
            end
          end

          -- Escape double quotes in the command
          local escaped_cmd = cmd:gsub('"', '\\"')

          -- Non-blocking jobstart so Neovim does not redraw or enter prompt state
          --
          -- Always ensure we’re back in normal mode before sending anything
          vim.fn.jobstart({ "tmux", "send-keys", "-t", pane_id, "-X", "cancel" })
          -- Clear the pane
          vim.fn.jobstart({ "tmux", "send-keys", "-t", pane_id, "C-l" })
          -- Send the testing command
          vim.fn.jobstart({
            "tmux",
            "send-keys",
            "-t",
            pane_id,
            escaped_cmd,
            "C-m",
          })
        end,
      }

      if in_tmate() then
        vim.g["test#strategy"] = "neovim_sticky"
      else
        vim.g["test#strategy"] = "tmux"
      end
    end,
    keys = {
      {
        "<leader>t",
        mode = { "n", "v" },
        desc = "[t]est file",
        function()
          vim.cmd("TestFile")
        end,
      },
      {
        "<leader>a",
        mode = { "n", "v" },
        desc = "Test suite",
        function()
          vim.cmd("TestSuite")
        end,
      },
      {
        "<leader>A",
        mode = { "n", "v" },
        desc = "Test suite",
        function()
          vim.cmd("TestSuite --only-failures")
        end,
      },
      {
        "<leader>s",
        mode = { "n", "v" },
        desc = "Test [s]ingle",
        function()
          vim.cmd("TestNearest")
        end,
      },
      {
        "<A-t>",
        mode = { "n", "v" },
        desc = "[o]utput",
        function()
          vim.cmd("TestOutput")
        end,
      },
    },
  },
}
