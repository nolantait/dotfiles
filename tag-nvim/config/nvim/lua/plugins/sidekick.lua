local tmux = require("utils.sidekick.tmux")

return {
  {
    "folke/sidekick.nvim",
    branch = "main",
    config = function()
      local sidekick = require("sidekick")
      local utils = require("sidekick.util")

      local original_exec = utils.exec

      -- Monkey patching to handle tmate
      ---@param cmd string[]
      ---@param opts? vim.SystemOpts|{notify?:boolean}
      utils.exec = function(cmd, opts)
        local isTmux = cmd[1] == "tmux"
        local insideTmate = vim.env.TMATE_SESSION

        if isTmux and insideTmate then
          cmd[1] = "tmate"
        end

        return original_exec(cmd, opts)
      end

      sidekick.setup({
        cli = {
          prompts = require("utils.sidekick.prompts"),
          mux = {
            backend = "tmux",
            enabled = true,
            create = "split",
            split = {
              size = 100,
            },
          },
        },
      })
    end,
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
          vim.defer_fn(tmux.add_files, 500) -- 500ms delay
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
