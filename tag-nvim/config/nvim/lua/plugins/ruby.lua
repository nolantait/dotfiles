-- DOCS: Ruby plugins for Neovim

vim.g.rails_projections = {
  ["packages/*"] = {
    ["app/commands/*.rb"] = {
      alternate = { "spec/commands/{}_spec.rb", "test/commands/{}_test.rb" },
      type = "command",
      template = {
        "class {camelcase|capitalize|colons}",
        "  def call",
        "  end",
        "end",
      },
    },
    ["spec/commands/*_spec.rb"] = {
      alternate = "app/commands/{}.rb",
      type = "test",
    },
    ["app/actions/*.rb"] = {
      alternate = { "spec/actions/{}_spec.rb", "test/actions/{}_test.rb" },
      type = "command",
      template = {
        "class {camelcase|capitalize|colons}",
        "  def call",
        "  end",
        "end",
      },
    },
    ["spec/actions/*_spec.rb"] = {
      alternate = "app/actions/{}.rb",
      type = "test",
    },
  },
}

return {
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
  },
  {
    "tpope/vim-rake",
    ft = { "ruby" },
  },
}
