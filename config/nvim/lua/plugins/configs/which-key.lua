-- Provides keymap suggestions when you start to type a motion and then stop

return function()
  local which_key = require("which-key")

  -- Set the timeout when whichkey will show up
  vim.o.timeout = true
  vim.o.timeoutlen = 300

  which_key.setup({
    plugins = {
      spelling = { enabled = true },
      presets = { operators = false },
    },
    window = {
      border = "rounded",
      padding = { 2, 2, 2, 2 },
    },
    disable = { filetypes = { "TelescopePrompt" } },
  })
end
