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
          require("sidekick.cli").toggle({
            name = "aider",
            focus = true,
          })

          -- Add each file in the current buffer to aider
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if
              vim.api.nvim_buf_is_loaded(buf)
              and vim.api.nvim_buf_get_option(buf, "buftype") == ""
            then
              local filename = vim.api.nvim_buf_get_name(buf)
              if filename ~= "" then
                require("sidekick.cli").send("/add " .. filename)
              end
            end
          end
        end,
        desc = "Sidekick Toggle CLI",
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
