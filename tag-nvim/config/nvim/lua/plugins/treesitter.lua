-- DOCS: Sets up treesitter which provides better syntax highlighting and
-- information about text objects to other plugins.

local config = function()
  local treesitter = require("nvim-treesitter")

  treesitter.setup({})

  local parsers = {
    "css",
    "embedded_template", -- ERB support
    "gitignore",
    "gitcommit",
    "gitattributes",
    "git_rebase",
    "html",
    "json",
    "javascript",
    "lua",
    "python",
    "ruby",
    "rust",
    "sql",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  }

  treesitter.install(parsers)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = parsers,
    callback = function()
      vim.treesitter.start()
    end,
  })
end

return {
  {
    -- Improved syntax highlighting and code understanding for other plugins
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    config = config,
    build = ":TSUpdate",
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "LazyFile",
  },
  {
    -- DOCS: This provides text object context to commenting plugins
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "LazyFile",
    opts = {
      enable = true,
      max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 20, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 1, -- Maximum number of lines to collapse for a single context line
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      zindex = 11, -- Needs to be lower than mini.map
    },
  },
}
