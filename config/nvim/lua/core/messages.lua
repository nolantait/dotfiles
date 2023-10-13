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
