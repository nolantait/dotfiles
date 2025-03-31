-- DOCS: AI code

return function()
  local avante = require("avante")

  avante.setup({
    -- add any opts here
    -- for example
    provider = "claude",
    cursor_applying_provider = "claude",
    behavior = {
      enable_claude_text_editor_tool_mode = true,
      enable_cursor_planning_mode = false, -- NOTE: uses Aider's method to planing when false, but is picky about the model chosen
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
        normal = "<C-CR>",
        insert = "<C-CR>",
      },
      sidebar = {
        close_from_input = {
          normal = "<C-q>",
          insert = "<C-q>"
        },
      }
    }
  })
end
