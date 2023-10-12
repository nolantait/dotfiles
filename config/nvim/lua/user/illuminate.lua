-- Highlight related words under the cursor

local ok, illuminate = prequire("illuminate")
if not ok then
  return
end

if illuminate then
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
