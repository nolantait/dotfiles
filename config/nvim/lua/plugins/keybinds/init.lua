-- DOCS: This returns a combined list of all individual pl

local plugin_keymaps = {
  "plugins.keybinds.trouble",
  "plugins.keybinds.dap",
  "plugins.keybinds.lsp",
  "plugins.keybinds.neotest",
  "plugins.keybinds.neotree",
  "plugins.keybinds.telescope",
}

local keymaps = {}

for _, path in ipairs(plugin_keymaps) do
  local mappings = require(path)

  for _, mapping in ipairs(mappings) do
    table.insert(keymaps, 1, mapping)
  end
end

return keymaps
