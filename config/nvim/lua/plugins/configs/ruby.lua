-- Customization for vim-ruby
-- TODO: Decide whether to remove this or use this plugin
-- it is currently unused

return function()
  local g = vim.g

  g.ruby_spellcheck_strings = 1
  g.ruby_line_continuation_error = 1
  g.ruby_space_errors = 1
  g.ruby_operators = 1
  g.ruby_pseudo_operators = 1
end
