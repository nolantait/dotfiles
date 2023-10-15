return function()
  local wilder = require("wilder")
  local icons = require("globals.icons")
  
  local highlighters = {
    wilder.basic_highlighter(),
    -- wilder.lua_pcre2_highlighter(),
    -- wilder.lua_fzy_highlighter(),
  }

  local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
    max_height = "50%",
    border = "rounded",
    highlights = {
      default = "Normal",
      border = "PmenuBorder",   -- highlight to use for the border
      accent = wilder.make_hl("WilderAccent", "CmpItemAbbr", "CmpItemAbbrMatch"),
    },
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = highlighters,
    left = {
      " ",
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags({
        flags = " a + ",
        icons = {
          ["+"] = icons.pencil,
          a = icons.arrow_right,
          h = icons.files.new
        },
      }),
    },
    right = {
      " ",
      wilder.popupmenu_scrollbar(),
    },
  }))

  local wildmenu_renderer = wilder.wildmenu_renderer({
    apply_incsearch_fix = false,
    highlighter = highlighters,
    separator = " · ",
    left = { " ", wilder.wildmenu_spinner(), " " },
    right = { " ", wilder.wildmenu_index() },
  })

  wilder.set_option(
    "renderer",
    wilder.renderer_mux({
      [":"] = popupmenu_renderer,
      ["/"] = wildmenu_renderer,
      substitute = wildmenu_renderer,
    })
  )

  wilder.setup({
    modes = {
      ":",
      "/",
      "?",
    }
  })
end
