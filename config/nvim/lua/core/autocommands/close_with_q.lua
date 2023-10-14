-- DOCS: This will remap q to close the window to make it easier to exit

return function(event)
  -- Do not show the buffer in the buffer list
  vim.bo[event.buf].buflisted = false

  vim.keymap.set(
    "n", -- When in Normal mode
    "q", -- And we press q
    "<cmd>close<cr>", -- Quit the buffer
    {
      buffer = event.buf, -- The buffer to quit
      silent = true -- Do not show the command in the command line
    }
  )
end
