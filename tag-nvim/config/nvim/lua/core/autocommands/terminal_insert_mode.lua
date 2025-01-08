return function()
  vim.schedule_wrap(function(data)
    -- Try to start terminal mode only if target terminal is current
    if
      not (
        vim.api.nvim_get_current_buf() == data.buf
        and vim.bo.buftype == "terminal"
      )
    then
      return
    end
    vim.cmd("startinsert")
  end)
end
