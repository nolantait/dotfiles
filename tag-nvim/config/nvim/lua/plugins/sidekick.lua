local find_aider_session = function()
  -- Find the aider tmux session
  local result =
    vim.system({ "tmux", "list-sessions", "-F", "#{session_name}" }):wait()
  local sessions = vim.split(result.stdout or "", "\n", { trimempty = true })
  local aider_session

  for _, s in ipairs(sessions) do
    if s:match("^aider") then
      aider_session = s
      break
    end
  end

  return aider_session
end

local add_files = function()
  local aider_session = find_aider_session()

  if not aider_session then
    vim.notify("Could not find aider tmux session", vim.log.levels.WARN)
    return
  end

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if
      vim.api.nvim_buf_is_loaded(buf)
      and vim.api.nvim_get_option_value("buflisted", { buf = buf })
    then
      -- Add all listed buffers to aider
      local filename = vim.api.nvim_buf_get_name(buf)
      if filename ~= "" then
        vim.system({
          "tmux",
          "send-keys",
          "-t",
          aider_session,
          "/add " .. filename,
          "Enter",
        })
      end
    end
  end
end

return {
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<Tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<C-Space>",
        function()
          require("sidekick.nes").update()
        end,
        mode = { "n" },
        desc = "Sidekick NES Update",
      },
      {
        "<Leader>ai",
        function()
          local sidekick = require("sidekick.cli")

          -- Open aider in Sidekick tmux
          sidekick.toggle({
            name = "aider",
            focus = true,
          })

          -- Delay 500ms to let the tmux session start
          vim.defer_fn(function()
            add_files()
          end, 500) -- 500ms delay
        end,
        desc = "Toggle Aider tmux session and add open files",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").select_prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },
}
