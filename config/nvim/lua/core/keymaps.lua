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
    silent = true
  }
}

local keymap = vim.api.nvim_set_keymap

local bind_keys = function(keybinds)
  for _, keybind in ipairs(keybinds) do
    if type(keybind.mode) == "table" then
      for _, mode in ipairs(keybind.mode) do
        keymap(
          mode,
          keybind.key,
          keybind.command,
          M.options
        )
      end
    else
      keymap(
        keybind.mode,
        keybind.key,
        keybind.command,
        M.options
      )
    end
  end
end


function M.setup()
  -- Unbind
  keymap("", "?", "<Nop>", M.options)
  keymap("", "<Leader>q", "<Nop>", M.options)

  -- Rebind W to w for fat finger saves
  vim.api.nvim_create_user_command("W", "w", { nargs = 0 })

  -- Sets up keymaps according to globals/keybinds.lua file
  bind_keys(M.keybinds)
end

return M
