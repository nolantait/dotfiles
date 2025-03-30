-- DOCS: Shows commands in the command line popup menu as you type starting with
-- a colon (:)

return function()
  local wilder = require("wilder")
  local icons = require("globals.icons")

  local highlighters = {
    wilder.basic_highlighter(),
    -- wilder.lua_pcre2_highlighter(),
    wilder.lua_fzy_highlighter(),
  }

  wilder.set_option("use_python_remote_plugin", 0)
  wilder.set_option("pipeline", {
    wilder.branch(
      wilder.cmdline_pipeline({
        fuzzy = 1,
        fuzzy_filter = wilder.lua_fzy_filter(),
      }),
      wilder.vim_search_pipeline(),
      {
        wilder.check(function(_, x)
          return x == ""
        end),
        wilder.history(),
        wilder.result({
          draw = {
            function(_, x)
              return icons.calendar .. x
            end,
          },
        }),
      }
    ),
  })

  local popupmenu_renderer =
    wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
      max_height = "50%",
      border = "none",
      highlights = {
        default = "Normal",
        border = "PmenuBorder",
        accent = wilder.make_hl(
          "WilderAccent",
          "CmpItemAbbr",
          "CmpItemAbbrMatch"
        ),
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
            h = icons.files.new,
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
    },
  })
end
