-- DOCS: This module provides a public API for notifications. We use it to make it
-- easy to change how notifications are sent within our config later.
--
-- local notify = require("core.messages")
-- notify.error("This is an error message")

local M = {}

local message = function(msg, level, opts)
  vim.notify(msg, level, opts)
end

function M.error(msg, title, opts)
  opts = opts or {}
  table.insert(opts, { title = title })

  message(msg, vim.log.levels.ERROR, opts)
end

function M.warn(msg, title, opts)
  opts = opts or {}
  table.insert(opts, { title = title })

  message(msg, vim.log.levels.WARN, opts)
end

function M.info(msg, title, opts)
  opts = opts or {}
  table.insert(opts, { title = title })

  message(msg, vim.log.levels.INFO, opts)
end

return M
