-- DOCS: This module provides a public API for notifications. We use it to make it
-- easy to change how notifications are sent within our config later.
--
-- local notify = require("core.messages")
-- notify.error("This is an error message")

local M = {}

function M.error(msg, title)
    vim.notify(msg, vim.log.levels.ERROR, { title = title })
end

function M.warn(msg, title)
    vim.notify(msg, vim.log.levels.WARN, { title = title })
end

function M.info(msg, title)
    vim.notify(msg, vim.log.levels.INFO, { title = title })
end

return M
