-- DOCS: Configuration for rails.vim

return function()
  -- Set the g:rails_projections table
  vim.g.rails_projections = {
    ["app/components/**/component.rb"] = {
      test = {
        "spec/components/{}_spec.rb",
      },
    },
    ["app/components/**/component.html.erb"] = {
      alternate = {
        "app/components/{}/component.rb",
      },
    },
    ["spec/components/*_spec.rb"] = {
      alternate = {
        "app/components/{}/component.rb",
      },
    },
  }
end
