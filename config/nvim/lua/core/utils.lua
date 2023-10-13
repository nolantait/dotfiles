-- Adds prequire function to global namespace

local notify = require("core.messages")

_G.prequire = function(plugin, verbose)
  local present, plug = pcall(require, plugin)

  if present then
      return present, plug
  end

  local errmsg = string.format("Could not load %s", plugin)
  if verbose then
      errmsg = string.format("%s\nError:%s", plug)
  end
  notify.error(errmsg, "Prequire failed")

  return present, nil
end
