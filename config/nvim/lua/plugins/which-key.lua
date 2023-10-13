-- Provides keymap suggestions when you start to type a motion and then stop

return function()
  local which_key = require("which-key")
  local keybinds = require("globals.keybinds")

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

    local opts = {
      mode = "n",       -- NORMAL mode
      prefix = "",      -- The prefix is prepended to every mapping part of `mappings`
      buffer = nil,     -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,    -- use `silent` when creating keymaps
      noremap = true,   -- use `noremap` when creating keymaps
      nowait = true,    -- use `nowait` when creating keymaps
    }


    local mappings = {}

    for _, keybind in ipairs(keybinds) do
      local key = keybind.key
      local command = keybind.command
      local description = keybind.description

      mappings[key] = { command, description }
    end

    -- Looks something like this:
    -- local mappings = {
    --   ["<leader>"] = { "<C-^>", "Switch to last file" },  -- Close current file
    --   ["e"] = { "<cmd>Neotree<CR>", "Plugin Manager" }, -- Invoking plugin manager
    --   ["q"] = { "<cmd>wqall!<CR>", "Quit" }, -- Quit Neovim after saving the file
    --   ["w"] = { "<cmd>w!<CR>", "Save" }, -- Save current file
    -- }

    which_key.register(mappings, opts)
end
