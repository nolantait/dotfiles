-- DOCS: Sets up treesitter which provides better syntax highlighting and
-- information about text objects to other plugins.

return function()
  local treesitter = require("nvim-treesitter.configs")

  treesitter.setup({
    ensure_installed = {
      "css",
      "elixir",
      "embedded_template",   -- ERB support
      "gitignore",
      "gitcommit",
      "gitattributes",
      "git_rebase",
      "heex",
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
      "yaml",
    },
    matchup = {
      enable = true
    },
    highlight = {
      enable = true,   -- false will disable the whole extension
      additional_vim_regex_highlighting = true,
      use_language_tree = true,
    },
    indent = {
      enable = true,
      disable = { "ruby" }
    }
  })
end
