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
      "Trouble",
      "alpha",
      "help",
      "toggleterm",
      "Empty"
    },
    under_cursor = true,
    max_file_lines = 10000,
  })
end
