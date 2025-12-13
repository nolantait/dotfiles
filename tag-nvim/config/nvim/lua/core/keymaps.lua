-- DOCS: Sets up keybinds

local M = {
  keybinds = require("globals.keybinds"),
  options = {
    -- Ensures that your mappings behave consistently and don't trigger unintended
    -- mappings. When you use noremap in a mapping definition, it tells Vim not
    -- to recursively map the right-hand side of the mapping.
    noremap = true,
    -- suppresses the display of most error messages and the displaying of the
    -- command executed. This is helpful to prevent error messages or status
    -- messages from appearing in the command line when the mapping is executed.
    silent = true,
    -- When set to true, the mapping will be executed without waiting for
    -- further input. This is particularly useful for mappings that
    -- involve multiple key presses or sequences, as it allows the mapping
    -- to be executed immediately without waiting for additional input.
    nowait = true
  },
}

local keymap = vim.api.nvim_set_keymap

local bind_keys = function(keybinds)
  for _, keybind in ipairs(keybinds) do
    local merged = vim.tbl_extend("force", M.options, keybind.options or {})

    if type(keybind.mode) == "table" then
      for _, mode in ipairs(keybind.mode) do
        keymap(mode, keybind.key, keybind.command, merged)
      end
    else
      keymap(keybind.mode, keybind.key, keybind.command, merged)
    end
  end
end

function M.setup()
  -- Unbind
  keymap("", "?", "<Nop>", M.options)
  keymap("", "<Leader>q", "<Nop>", M.options)
  -- Remove default cmdwin mappings to prevent conflicts
  keymap("n", "q:", "<Nop>", M.options)
  keymap("n", "q/", "<Nop>", M.options)
  keymap("n", "q?", "<Nop>", M.options)

  -- Rebind W to w for fat finger saves
  vim.api.nvim_create_user_command("W", "w", { nargs = 0 })

  -- Sets up keymaps according to globals/keybinds.lua file
  bind_keys(M.keybinds)
end

return M
