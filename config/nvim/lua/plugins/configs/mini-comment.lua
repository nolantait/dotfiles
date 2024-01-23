-- DOCS: Smart comments with gc

return function()
  vim.g.skip_ts_context_commentstring_module = true

  local mini_comment = require("mini.comment")
  local commentstring = require("ts_context_commentstring")

  mini_comment.setup({
    options = {
      custom_commentstring = function()
        return commentstring.calculate_commentstring() or vim.bo.commentstring
      end,
    },
    mappings = {
      comment = "gc",
      comment_line = "gcc",
      comment_visual = "gc",
      textobject = "gc"
    }
  })
end
