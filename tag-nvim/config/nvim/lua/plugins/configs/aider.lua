-- DOCS: AI coding assistant for Neovim with open source aider
-- https://aider.chat/

return function()
  local aider = require("aider")

  aider.setup({
    auto_manage_context = true,
    default_bindings = false,
    debug = false,
    ignore_buffers = {
      "^term:",
      "NeogitConsole",
      "NvimTree_",
      "neo-tree filesystem",
    },
  })
end
