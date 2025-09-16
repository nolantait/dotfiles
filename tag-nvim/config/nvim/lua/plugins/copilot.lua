-- DOCS: Copilot setup

return {
  {
    -- Auto completion using Github's copilot
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      cmp = {
        enabled = true,
        -- method = "getCompletionsCycling",
      },
      copilot_node_command = "node", -- Node.js version must be > 16.x
      filetypes = {
        alpha = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        text = false,
        sh = function()
          if
            string.match(
              vim.fs.basename(vim.api.nvim_buf_get_name(0)),
              "^%.env.*"
            )
          then
            -- disable for .env files
            return false
          end
          return true
        end,
        ["neo-tree"] = false,
        ["dap-repl"] = false,
        ["yaml.ansible"] = true,
        ["."] = false,
      },
      panel = {
        -- Disabled to not interfere with copilot-cmp
        enabled = false,
      },
      suggestion = {
        enabled = false,
        -- auto_trigger = true,
        -- enabled = true,
        -- keymap = {
        --   accept = "<M-l>",
        --   accept_word = false,
        --   accept_line = "<M-L>",
        --   next = "<M-]>",
        --   prev = "<M-[>",
        --   dismiss = "<C-]>",
        -- },
      },
      server_opts_overrides = {
        settings = {
          telemetry = {
            telemetryLevel = "off",
          },
        },
      },
    },
  },
}
