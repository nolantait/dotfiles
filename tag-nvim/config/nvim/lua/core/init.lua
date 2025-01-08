-- DOCS: Load all the rest of the files in the core folder
-- This lets us just call require("core") to load everything in init.lua
-- lua will look for a file named init.lua by default if the path is a folder

local M = {}

function M.setup()
  local modules = {
    "vim",
    "prequire",
    "keymaps",
    "autocommands",
  }

  for _, module in ipairs(modules) do
    require("core." .. module).setup()
  end
end

return M
