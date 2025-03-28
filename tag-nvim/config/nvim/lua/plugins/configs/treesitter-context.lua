-- DOCS: This provides text object context to commenting plugins

return function()
  local treesitter_context = require("treesitter-context")

  treesitter_context.setup({
    enable = true,
    max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 20, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 1, -- Maximum number of lines to collapse for a single context line
    trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
    zindex = 11, -- Needs to be lower than mini.map
  })
end
