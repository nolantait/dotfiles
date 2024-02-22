-- DOCS: Powerline on the bottom of the screen

return function()
  local lualine = require("lualine")
  local colors = require("globals.colors")
  local icons = require("globals.icons")

  local lualine_colors = {
    a = {
      bg = colors.dark_gray,
      fg = colors.white,
    },
    b = {
      bg = colors.darker_gray,
      fg = colors.white,
    },
    c = {
      bg = colors.black,
      fg = colors.white,
    },
  }

  local theme = {
    normal = {
      a = { fg = lualine_colors.a.fg, bg = lualine_colors.a.bg },
      b = { fg = lualine_colors.b.fg, bg = lualine_colors.b.bg },
      c = { fg = lualine_colors.c.fg, bg = lualine_colors.c.bg },
    },
    command = { a = { fg = colors.black, bg = colors.orange, gui = "bold" } },
    insert = { a = { fg = colors.black, bg = colors.blue, gui = "bold" } },
    visual = { a = { fg = colors.black, bg = colors.yellow, gui = "bold" } },
    replace = { a = { fg = colors.black, bg = colors.green, gui = "bold" } },
    terminal = { a = { fg = colors.black, bg = colors.cyan, gui = "bold" } },
    inactive = {
      a = { fg = colors.white, bg = colors.black, gui = "bold" },
      b = { fg = colors.white, bg = colors.black },
      c = { fg = colors.white, bg = colors.black },
    }
  }

  local empty = require("lualine.component"):extend()
  function empty:draw(default_highlight)
    self.status = ""
    self.applied_separator = ""
    self:apply_highlights(default_highlight)
    self:apply_section_separators()
    return self.status
  end

  local has_enough_room = function()
    return vim.o.columns > 100
  end

  local error = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error" },
    symbols = { error = icons.error .. " " },
    update_in_insert = false,
    always_visible = true,
    diagnostics_color = { error = { bg = lualine_colors.b.bg, fg = colors.red } },
  }

  local warn = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "warn" },
    symbols = { warn = icons.warn .. " " },
    update_in_insert = false,
    always_visible = true,
    diagnostics_color = { warn = { bg = lualine_colors.b.bg, fg = colors.yellow } },
  }

  local diff = {
    "diff",
    colored = true,
    symbols = {
      added = icons.git.added .. " ",
      modified = icons.git.modified .. " ",
      removed = icons.git.removed .. " "
    }, -- changes diff symbols
    cond = has_enough_room
  }

  local mode = {
    "mode",
    fmt = function(str)
      return str
    end,
  }

  local filetype = {
    "filetype",
    colored = true,
    icon_only = false,
    icon = { align = "left" },
    cond = has_enough_room
  }

  local branch = {
    "branch",
    icons_enabled = true,
    icon = icons.git.branch,
  }

  local copilot_status = {
    "copilot",
    cond = has_enough_room,
    padding = { left = 1 },
    symbols = {
      status = {
        hl = {
          enabled = colors.green,
          sleep = colors.light_gray,
          disabled = colors.red,
          warning = colors.yellow,
          unknown = colors.blue
        }
      }
    },
    show_colors = true
  }

  local file_location = {
    require("components.file_location"),
    padding = 0
  }

  local cwd = {
    require("components.cwd"),
    padding = 1,
    color = { fg = colors.light_gray },
    cond = has_enough_room
  }

  local lsp_status = {
    require("components.lsp_status"),
    color = { fg = colors.light_gray },
    cond = has_enough_room,
    padding = 1
  }

  local encoding = {
    "encoding",
    cond = has_enough_room
  }

  local fileformat = {
    "fileformat",
    symbols = {
      unix = "LF",
      dos = "CRLF",
      mac = "CR"
    },
    padding = { right = 1 }
  }

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = { left = "", right = "" },
      section_separators = {
        left = icons.separators.top_left_wedge,
        right = icons.separators.left_semicircle
      },
      disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { mode, error, warn },
      lualine_b = { branch },
      lualine_c = { "filename" },
      lualine_x = { diff, encoding, fileformat, filetype, copilot_status, lsp_status },
      lualine_y = { cwd },
      lualine_z = { file_location },
    },
    tabline = {},
    extensions = {},
  })
end
