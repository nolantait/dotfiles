return function()
  vim.g.skip_ts_context_commentstring_module = true

  local mini_comment = require("mini.comment")

  mini_comment.setup({
    options = {
      custom_commentstring = function()
        return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
      end,
    }
  })
end
