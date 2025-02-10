-- DOCS: This will jump to the last cursor position

return function(event)
  local exclude = { "gitcommit" }
  local buf = event.buf
  if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.bo[buf].already_last_loc then
    return
  end

  vim.bo[buf].already_last_loc = true

  -- Get the position of the last jump
  local mark = vim.api.nvim_buf_get_mark(0, '"')

  -- Get the number of lines in the current buffer
  local line_count = vim.api.nvim_buf_line_count(0)

  -- If the mark is valid and is in the current buffer
  if mark[1] > 0 and mark[1] <= line_count then
    -- Jump to the mark
    pcall(vim.api.nvim_win_set_cursor, 0, mark)
  end
end
