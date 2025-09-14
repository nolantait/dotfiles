-- DOCS: AI code

return {
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    keys = {
      {
        "<Leader>ai",
        mode = "n",
        desc = "Open ai with Avante",
        function()
          vim.cmd("AvanteAsk")
        end,
      },
      {
        "<Leader>ac",
        mode = "n",
        desc = "Chat with Avante",
        function()
          vim.cmd("AvanteChat")
        end,
      },
      {
        "<Leader>aC",
        mode = "n",
        desc = "Clear chat with Avante",
        function()
          vim.cmd("AvanteClear")
        end,
      },
      -- {
      --   "<Leader>ad",
      --   mode = "n",
      --   desc = "Toggle Avante debug",
      --   function()
      --     vim.cmd("AvanteDebug")
      --   end,
      -- },
      {
        "<Leader>am",
        mode = "n",
        desc = "Open list of models",
        function()
          vim.cmd("AvanteModels")
        end,
      },
      {
        "<Leader>ah",
        mode = "n",
        desc = "Open previous chats",
        function()
          vim.cmd("AvanteHistory")
        end,
      },
      {
        "<Leader>ar",
        mode = "n",
        desc = "Show repo map with Avante",
        function()
          vim.cmd("AvanteShowRepoMap")
        end,
      },
    },
    opts = {
      -- add any opts here
      -- for example
      provider = "claude",
      cursor_applying_provider = "openai_mini",
      behavior = {
        enable_claude_text_editor_tool_mode = true,
        -- NOTE: uses Aider's method to planing when false, but is picky about
        -- the model chosen
        enable_cursor_planning_mode = false,
        auto_approve_tool_permissions = false,
      },
      file_selector = {
        provider = "telescope",
      },
      providers = {
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4.1", -- your desired model (or use gpt-4o, etc.)
          timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
          extra_request_body = {
            max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
            reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
            options = {
              temperature = 0,
              num_ctx = 20480,
              keep_alive = "5m",
            },
          },
        },
        openai_mini = {
          __inherited_from = "openai", -- inherit from openai provider
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4.1-mini", -- your desired model (or use gpt-4o-mini, etc.)
        },
        deepseek = {
          __inherited_from = "openai", -- inherit from openai provider
          endpoint = "https://api.deepseek.com",
          model = "deepseek-coder",
        },
        claude = {
          __inherited_from = "openai", -- inherit from openai provider
          endpoint = "https://api.anthropic.com",
          model = "claude-4-sonnet-latest",
          disable_tools = false,
        },
      },
      mappings = {
        submit = {
          normal = "<C-A>",
          insert = "<C-A>",
        },
        sidebar = {
          close_from_input = {
            normal = "<C-q>",
            insert = "<C-q>",
          },
        },
      },
      input = {
        provider = "snacks",
        provider_opts = {
          title = "Avante Input",
          icon = "",
        },
      },
      custom_tools = {
        {
          name = "run_ruby_tests", -- Unique name for the tool
          description = "Run Ruby unit tests and return results", -- Description shown to AI
          command = "bin/rspec", -- Shell command to execute
          param = { -- Input parameters (optional)
            type = "table",
            fields = {
              {
                name = "target",
                description = "File or directory to test (e.g. '.' or 'packages')",
                type = "string",
                optional = true,
              },
            },
          },
          returns = { -- Expected return values
            {
              name = "result",
              description = "Result of the fetch",
              type = "string",
            },
            {
              name = "error",
              description = "Error message if the fetch was not successful",
              type = "string",
              optional = true,
            },
          },
          func = function(params, on_log, on_complete) -- Custom function to execute
            local target = params.target or "."
            return vim.fn.system(string.format("bin/rspec %s", target))
          end,
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    cmd = {
      "AvanteAsk",
      "AvanteBuild",
      "AvanteChat",
      "AvanteClear",
      "AvanteEdit",
      "AvanteFocus",
      "AvanteHistory",
      "AvanteModels",
      "AvanteRefresh",
      "AvanteShowRepoMap",
      "AvanteStop",
      "AvanteSwitchFileSectorProvider",
      "AvanteSwitchProvider",
      "AvanteToggle",
      "AvanteToggle",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or nvim-mini/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
  },
}
