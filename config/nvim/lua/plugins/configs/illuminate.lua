-- DOCS: Highlight related words under the cursor

return function()
  local illuminate = require("illuminate")

  illuminate.configure({
    delay = 200,
    providers = {
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
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" }
    },
    max_file_lines = 2000,
    min_count_to_highlight = 1,
    under_cursor = true,
  })
end
