-- DOCS: Copilot setup

return {
  -- {
  --   "copilotlsp-nvim/copilot-lsp",
  -- },
  {
    -- Auto completion using Github's copilot
    "zbirenbaum/copilot.lua",
    -- requires = {
    --   "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    -- },
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
      nes = {
        enabled = false,
        auto_trigger = true,
        debounce = 100,
        keymap = {
          accept_and_goto = false,
          accept = false,
          dismiss = false,
        },
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
      server = {
        type = "binary",
        custom_server_filepath = "~/.local/share/nvim/mason/bin/copilot-language-server",
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
