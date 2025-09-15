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

          -- Only create pane if we don't have one
          if not pane_id or pane_id == "" then
            -- Create pane at 12 lines high directly (avoids resize flash)
            local new_pane_id =
              shell("tmux split-window -P -F '#{pane_id}' -v -l 12")
            vim.g[pane_var] = new_pane_id
            pane_id = new_pane_id
          else
            -- Recreate if pane no longer exists
            local exists = os.execute(
              "tmux list-panes -F '#{pane_id}' | grep -q " .. pane_id
            )
            if exists ~= 0 then
              vim.g[pane_var] = nil
              return vim.g["test#custom_strategies"].tmux(cmd)
            end
          end

          local escaped_cmd = cmd:gsub('"', '\\"')
          os.execute("tmux send-keys -t " .. pane_id .. " C-l")
          os.execute(
            "tmux send-keys -t " .. pane_id .. ' "' .. escaped_cmd .. '" Enter'
          )
        end,
      }

      vim.g["test#strategy"] = "tmux"
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
