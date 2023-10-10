-- Adds prequire function to global namespace

local M = {}

function M.error(msg, name)
    vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

_G.prequire = function(plugin, verbose)
  local present, plug = pcall(require, plugin)

  if present then
      return present, plug
  end

  local errmsg = string.format("Could not load %s", plugin)
  if verbose then
      errmsg = string.format("%s\nError:%s", plug)
  end
  M.error(errmsg, "Prequire failed")

  return present, nil
end
