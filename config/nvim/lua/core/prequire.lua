-- DOCS: Adds prequire function to global namespace. Prequire is a convention
-- that is like pcall but will also notify the user of the error. It is added to
-- _G which will make it globally available without import.
--
-- pcall(require, "some_plugin") would fail silently
-- prequire("some_plugin") will notify of the failure

local notify = require("core.messages")

local M = {}

function M.setup()
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
end

return M
