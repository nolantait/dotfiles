-- DOCS: Sets up keybinds

local keymap = vim.api.nvim_set_keymap
local options = {
  -- Ensures that your mappings behave consistently and don't trigger unintended
  -- mappings. When you use noremap in a mapping definition, it tells Vim not
  -- to recursively map the right-hand side of the mapping.
  noremap = true,
  -- suppresses the display of most error messages and the displaying of the
  -- command executed. This is helpful to prevent error messages or status
  -- messages from appearing in the command line when the mapping is executed.
  silent = true
}

-- Unbind ?
keymap("", "?", "<Nop>", options)
-- Rebind :W to :w to make it easier to save files when fat fingering
vim.cmd("command! W w")

local bind_keys = function(keybinds)
  for _, keybind in ipairs(keybinds) do
    keymap(
      keybind.mode,
      keybind.key,
      keybind.command,
      options
    )
  end
end

-- Sets up keymaps according to globals/keybinds.lua file
bind_keys(require("globals.keybinds"))
