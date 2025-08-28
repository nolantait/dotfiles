-- DOCS: Smart comments with gc

local custom_commentstring = function()
  local ok, commentstring = prequire("ts_context_commentstring")
  if ok and commentstring then
    return commentstring.calculate_commentstring() or vim.bo.commentstring
  end
end

return {
  {
    -- Automatic commenting with gc
    "nvim-mini/mini.comment",
    event = "LazyFile",
    init = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
    opts = {
      options = {
        custom_commentstring = custom_commentstring,
      },
      mappings = {
        comment = "gc",
        comment_line = "gcc",
        comment_visual = "gc",
        textobject = "gc",
      },
    },
  },
}
