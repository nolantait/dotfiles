-- Highlight related words under the cursor

return function()
  local illuminate = require("illuminate")

  illuminate.configure({
    delay = 100,
    providers = {
      "lsp",
      "treesitter",
      "regex"
    },
    filetypes_denylist = {
      "DressingSelect",
      "NvimTree",
      "Outline",
      "TelescopePrompt",
      "alpha",
      "help",
      "toggleterm"
    },
    under_cursor = false
  })
end
