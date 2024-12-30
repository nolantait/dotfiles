-- DOCS: Barbecue is a VS Code-like winbar for Neovim written in Lua.
-- Uses nvim-navic in order to get LSP context from your language server.

return function()
  local barbecue = require("barbecue")
  local colors = require("globals.colors")

  barbecue.setup({
    -- prevent barbecue from automatically attaching nvim-navic
    -- We will do it manually in config/nvim/lua/user/lsp/handlers.lua
    attach_navic = false,
    theme = {
      normal = { fg = colors.white },
      -- these highlights correspond to symbols table from config
      ellipsis = { fg = colors.light_gray },
      separator = { fg = colors.light_gray },
      modified = { fg = colors.light_gray },
      -- these highlights represent the _text_ of three main parts of barbecue
      dirname = { fg = colors.light_gray },
      basename = { bold = true },
      context = {},
      -- these highlights are used for context/navic icons
      context_file = { fg = colors.green },
      context_module = { fg = colors.yellow },
      context_namespace = { fg = colors.yellow },
      context_package = { fg = colors.purple },
      context_class = { fg = colors.yellow },
      context_method = { fg = colors.blue },
      context_property = { fg = colors.red },
      context_field = { fg = colors.purple },
      context_constructor = { fg = colors.purple },
      context_enum = { fg = colors.yellow },
      context_interface = { fg = colors.yellow },
      context_function = { fg = colors.blue },
      context_variable = { fg = colors.red },
      context_constant = { fg = colors.yellow },
      context_string = { fg = colors.green },
      context_number = { fg = colors.red },
      context_boolean = { fg = colors.orange },
      context_array = { fg = colors.purple },
      context_object = { fg = colors.purple },
      context_key = { fg = colors.purple },
      context_null = { fg = colors.purple },
      context_enum_member = { fg = colors.purple },
      context_struct = { fg = colors.yellow },
      context_event = { fg = colors.purple },
      context_operator = { fg = colors.purple },
      context_type_parameter = { fg = colors.purple },
    },
  })
end
