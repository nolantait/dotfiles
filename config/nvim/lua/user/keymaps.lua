-- Sets up keymaps according to keybinds file

local keybinds = require("user.keybinds")

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Unbind ?
keymap("", "?", "<Nop>", opts)

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

for _, keybind in ipairs(keybinds) do
  keymap(keybind.mode, keybind.key, keybind.command, opts)
end

vim.cmd([[
  cnoreabbrev W w
]])
