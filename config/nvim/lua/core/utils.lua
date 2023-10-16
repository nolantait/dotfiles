-- DOCS: General purpose utility functions for filesystem navigation

local M = {}

M.border = function(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

function M.debounce(ms, fn)
  local timer = vim.loop.new_timer()

  return function(...)
    local argv = vim.F.pack_len(...)
    if timer then
      timer:start(ms, 0, function()
        timer:stop()
        vim.schedule_wrap(fn)(vim.F.unpack_len(argv))
      end)
    end
  end
end

return M
