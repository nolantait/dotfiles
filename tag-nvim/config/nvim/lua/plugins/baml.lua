-- DOCS: Adds baml syntax

return {
  {
    "klepp0/nvim-baml-syntax",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "baml" }, -- This ensures the plugin is loaded for baml files
    config = function()
      -- This ensures lua/baml_syntax/init.lua is run,
      -- which registers the "baml" parser and configures Tree-sitter:
      require("baml_syntax").setup()
    end,
  },
}
