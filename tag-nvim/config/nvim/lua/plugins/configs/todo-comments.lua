-- DOCS: This provides the special highlighting for various comments
-- such as this one

return function()
  local todo_comments = require("todo-comments")
  local colors = require("globals.colors")
  local icons = require("globals.icons")

  todo_comments.setup({
    signs = true,        -- show icons in the signs column
    sign_priority = 8,   -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = icons.bug, -- icon used for the sign, and in search results
        color = colors.red, -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = {
        icon = icons.check,
        color = colors.yellow,
        alt = { "TIP" }
      },
      HACK = {
        icon = icons.fire,
        color = colors.red
      },
      WARN = {
        icon = icons.warn,
        color = colors.yellow,
        alt = { "WARNING", "XXX" }
      },
      PERF = {
        icon = icons.performance,
        color = colors.purple,
        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }
      },
      NOTE = {
        icon = icons.info,
        color = colors.green,
        alt = { "INFO" }
      },
      TEST = {
        icon = icons.test,
        color = colors.green,
        alt = { "TESTING", "PASSED", "FAILED" }
      },
      DOCS = {
        icon = icons.info,
        color = colors.lighter_gray
      },
      PRIVATE = {
        icon = icons.lock,
        color = colors.blue
      }
    },
    gui_style = {
      fg = "NONE",           -- The gui style to use for the fg highlight group.
      bg = "BOLD",           -- The gui style to use for the bg highlight group.
    },
    merge_keywords = true,   -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      multiline = true,                      -- enable multine todo comments
      multiline_pattern = "^.",              -- lua pattern to match the next multiline from the start of the matched keyword
      multiline_context = 10,                -- extra lines that will be re-evaluated when changing a line
      before = "",                           -- "fg" or "bg" or empty
      keyword = "bg",                        -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = "fg",                          -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)\s*:]],       -- pattern or table of patterns, used for highlightng (vim regex)
      comments_only = true,                  -- uses treesitter to match keywords in comments only
      max_line_len = 400,                    -- ignore lines longer than this
      exclude = { "help", "checkhealth" },   -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
    -- colors = {
    --   error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
    --   warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
    --   info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
    --   hint = { "LspDiagnosticsDefaultHint", "#10B981" },
    --   default = { "Identifier", "#7C3AED" },
    -- },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS):]],   -- ripgrep regex
      -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
  })
end
