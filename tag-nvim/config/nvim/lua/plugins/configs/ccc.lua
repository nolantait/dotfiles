-- DOCS: Color picker utility with <leader>cp

return function()
  local colors = require("globals.colors")
  local ccc = require("ccc")

  ccc.setup({
    inputs = {
      ccc.input.rgb,
      ccc.input.hsl,
      ccc.input.cmyk,
      ccc.input.okhsl,
    },
    outputs = {
      ccc.output.hex,
      ccc.output.hex_short,
      ccc.css_rgb,
      ccc.css_hsl,
      ccc.css_oklch,
    },
    pickers = {
      ccc.picker.hex,
      ccc.picker.css_rgb,
      ccc.picker.css_hsl,
      ccc.picker.css_hwb,
      ccc.picker.css_lab,
      ccc.picker.css_lch,
      ccc.picker.css_oklab,
      ccc.picker.css_oklch,
      ccc.picker.custom_entries(colors),
    },
    highlighter = {
      auto_enable = false,
      lsp = false,
    },
  })
end
