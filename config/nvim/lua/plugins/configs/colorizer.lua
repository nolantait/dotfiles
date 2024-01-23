-- DOCS: Color hex codes and other colors are highlighted automatically

return function()
  local colorizer = require("colorizer")

  if colorizer then
    colorizer.setup({
      filetypes = { "*" },
      buftypes = { "*" },
      user_default_options = {
        RGB      = true,  -- #RGB hex codes
        RRGGBB   = true,  -- #RRGGBB hex codes
        names    = false, -- "Name" codes like Blue
        RRGGBBAA = true,  -- #RRGGBBAA hex codes
        rgb_fn   = true,  -- CSS rgb() and rgba() functions
        hsl_fn   = true,  -- CSS hsl() and hsla() functions
        css      = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn   = true,  -- Enable all CSS *functions*: rgb_fn, hsl_fn
        tailwind = true,  -- Enable all tailwindcss features: rgb_fn, RRGGBB, names
      }
    })

    -- execute colorizer as soon as possible
    vim.defer_fn(function()
      colorizer.attach_to_buffer(0)
    end, 0)
  end
end
