local copilot_status = require("components.copilot").get_status

local status_ok, lualine = prequire("lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local colors = {
  -- Start flavours
  -- Base16 OneDark
  -- Author: Lalit Magant (http://github.com/tilal6991)
  -- Sets up the theme for base16-vim
  red = '#e06c75',
  grey = '#3e4451',
  light_gray = '#545862',
  black = '#282c34',
  white = '#c8ccd4',
  green = '#98c379',
  orange = '#d19a66',
  yellow = '#e5c07b',
  magenta = '#c678dd',
  blue = '#61afef',
  -- End flavours
}

local theme = {
  normal = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white, bg = colors.light_gray },
    z = { fg = colors.white, bg = colors.black },
  },
  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.yellow } },
  replace = { a = { fg = colors.black, bg = colors.green } },
}

local empty = require("lualine.component"):extend()
function empty:draw(default_highlight)
  self.status = ""
  self.applied_separator = ""
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < "x"
    for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.black, bg = colors.gray } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= "table" then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = "" } or { left = "" }
    end
  end
  return sections
end


local error = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error" },
  symbols = { error = " " },
  update_in_insert = false,
  always_visible = true,
  diagnostics_color = { error = { bg = colors.black, fg = colors.red } },
}

local warn = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "warn" },
  symbols = { warn = " " },
  update_in_insert = false,
  always_visible = true,
  diagnostics_color = { warn = { bg = colors.black, fg = colors.orange } },
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local mode = {
  "mode",
  fmt = function(str)
    return str
  end,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local location = {
  "location",
  padding = 0,
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = process_sections({
    lualine_a = { branch, error, warn },
    lualine_b = { mode, copilot_status },
    lualine_c = { "filename" },
    -- lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_x = { diff, "encoding", filetype },
    lualine_y = { location },
    lualine_z = {},
  }),
  tabline = {},
  extensions = {},
})
