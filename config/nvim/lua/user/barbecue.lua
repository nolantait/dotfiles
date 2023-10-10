-- Barbecue is a VS Code-like winbar for Neovim written in Lua.
-- Uses nvim-navic in order to get LSP context from your language server.

local ok, barbecue = prequire("barbecue")
if not ok then
  return
end

if barbecue then
  barbecue.setup({
  -- prevent barbecue from automatically attaching nvim-navic
  -- We will do it manually in config/nvim/lua/user/lsp/handlers.lua
    attach_navic = false,
    theme = {
  -- Start flavours
      -- Base16 OneDark
      -- Author: Lalit Magant (http://github.com/tilal6991)
      -- Sets up the theme for base16-vim

      -- this highlight is used to override other highlights
      -- you can take advantage of its `bg` and set a background throughout your winbar
      -- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
      normal = { fg = "#c8ccd4" },

      -- these highlights correspond to symbols table from config
      ellipsis = { fg = "#565c64" },
      separator = { fg = "#565c64" },
      modified = { fg = "#565c64" },

      -- these highlights represent the _text_ of three main parts of barbecue
      dirname = { fg = "#565c64" },
      basename = { bold = true },
      context = {},

      -- these highlights are used for context/navic icons
      context_file = { fg = "#c678dd" },
      context_module = { fg = "#c678dd" },
      context_namespace = { fg = "#c678dd" },
      context_package = { fg = "#c678dd" },
      context_class = { fg = "#c678dd" },
      context_method = { fg = "#c678dd" },
      context_property = { fg = "#c678dd" },
      context_field = { fg = "#c678dd" },
      context_constructor = { fg = "#c678dd" },
      context_enum = { fg = "#c678dd" },
      context_interface = { fg = "#c678dd" },
      context_function = { fg = "#c678dd" },
      context_variable = { fg = "#c678dd" },
      context_constant = { fg = "#c678dd" },
      context_string = { fg = "#c678dd" },
      context_number = { fg = "#c678dd" },
      context_boolean = { fg = "#c678dd" },
      context_array = { fg = "#c678dd" },
      context_object = { fg = "#c678dd" },
      context_key = { fg = "#c678dd" },
      context_null = { fg = "#c678dd" },
      context_enum_member = { fg = "#c678dd" },
      context_struct = { fg = "#c678dd" },
      context_event = { fg = "#c678dd" },
      context_operator = { fg = "#c678dd" },
      context_type_parameter = { fg = "#c678dd" },
  -- End flavours
    },
  })
end
