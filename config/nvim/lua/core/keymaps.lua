-- Sets up keybinds

local keybinds = require("globals.keybinds")
local options = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Unbind ?
keymap("", "?", "<Nop>", options)
-- Rebind :W to :w to make it easier to save files when fat fingering
keymap("c", "W", "w", options)

-- Sets up keymaps according to keybinds file
for _, keybind in ipairs(keybinds) do
  keymap(keybind.mode, keybind.key, keybind.command, options)
end


