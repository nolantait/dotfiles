return function()
  local treesitter = require("nvim-treesitter.configs")

  treesitter.setup({
    context_commentstring = {
      enable = true,
      enable_autocmd = false
    },
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
