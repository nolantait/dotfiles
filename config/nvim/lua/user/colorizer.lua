local ok, colorizer = prequire("colorizer")
if not ok then
  return
end

if colorizer then
  colorizer.setup(
    {"*";}, -- Highlight all files, but customize some others.
    {
        RGB      = true;         -- #RGB hex codes
        RRGGBB   = true;         -- #RRGGBB hex codes
        names    = true;         -- "Name" codes like Blue
        RRGGBBAA = true;         -- #RRGGBBAA hex codes
        rgb_fn   = true;         -- CSS rgb() and rgba() functions
        hsl_fn   = true;         -- CSS hsl() and hsla() functions
        css      = true;         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn   = true;         -- Enable all CSS *functions*: rgb_fn, hsl_fn
    }
  )

  -- execute colorizer as soon as possible
  vim.defer_fn(function()
    colorizer.attach_to_buffer(0)
  end, 0)
end
