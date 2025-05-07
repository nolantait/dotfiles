-- DOCS: AI code

return {
  {
    "yetone/avante.nvim",
    enabled = true,
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
      cursor_applying_provider = "claude",
      behavior = {
        enable_claude_text_editor_tool_mode = true,
        -- NOTE: uses Aider's method to planing when false, but is picky about
        -- the model chosen
        enable_cursor_planning_mode = false,
      },
      file_selector = {
        provider = "telescope",
      },
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-7-sonnet-latest",
        temperature = 0,
        max_tokens = 4096,
        disable_tools = false,
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
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      "MeanderingProgrammer/render-markdown.nvim",
    },
  },
}
