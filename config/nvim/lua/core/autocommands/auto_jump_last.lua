-- DOCS: This will jump to the last cursor position

return function()
  -- Get the position of the last jump
  local mark = vim.api.nvim_buf_get_mark(0, '"')

  -- Get the number of lines in the current buffer
  local lcount = vim.api.nvim_buf_line_count(0)

  -- If the mark is valid and is in the current buffer
  if mark[1] > 0 and mark[1] <= lcount then
    -- Jump to the mark
    pcall(vim.api.nvim_win_set_cursor, 0, mark)
  end
end
