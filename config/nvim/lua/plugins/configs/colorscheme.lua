-- DOCS: Setting up custom colors and highlights through mini.base16

return function()
  -- local base16 = require("mini.base16")
  local base16 = require("globals.colors")
  local theme = require("colorbuddy")

  local Color = theme.Color
  local colors = theme.colors
  local Group = theme.Group
  local groups = theme.groups
  local styles = theme.styles

  -- Setup colors
  Color.new("Background", "#16181d")
  for name, color in pairs(base16) do
    Color.new(name, color)
  end

  local highlight_groups = {
    { "Background",   colors.lighter_gray,  colors.background },
    { "Normal",       colors.lighter_gray,  colors.black },
    { "Cursor",       colors.white,         colors.black },
    { "CursorLine",   nil,                  colors.darker_gray },
    { "Visual",       nil,                  colors.dark_gray },
    { "Directory",    colors.blue,          nil },
    { "DiffAdd",      colors.green,         nil },
    { "DiffChange",   colors.orange,        nil },
    { "DiffDelete",   colors.red,           nil },
    { "DiffText",     colors.yellow,        nil },
    { "NonText",      colors.darker_gray,   colors.black },
    { "Error",        colors.red,           nil },
    { "WinSeparator", colors.background,    colors.background },
    { "Folded",       colors.light_gray,    colors.black },
    { "LineNr",       colors.dark_gray,     colors.background },
    { "Search",       colors.black,         colors.yellow },
    { "MatchParen",   colors.lightest_gray, colors.light_gray,   styles.bold },
    { "NormalFloat",  colors.lighter_gray,  colors.black },
    { "Title",        colors.blue,          nil },
    { "PmenuThumb",   colors.lightest_gray, colors.lightest_gray },
    { "TabLine",      colors.gray,          colors.darker_gray },
    { "Special",      colors.cyan,          nil },
    { "Constant",     colors.orange,        nil },
    { "Function",     colors.blue,          nil },
    { "Keyword",      colors.purple,        nil },
    { "Comment",      colors.gray,          nil },
    { "Info",         colors.cyan,          nil },
    { "Todo",         colors.yellow,        nil,                 styles.bold },
    { "Warn",         colors.yellow,        nil },
    { "Changed",      colors.orange,        nil },
    { "Success",      colors.green,         nil },
    { "Identifier",   colors.red,           nil },
    { "Conditional",  colors.purple,        nil },
    { "Label",        colors.yellow,        nil },
    { "String",       colors.green,         nil },
    { "Delimiter",    colors.red,           nil },
    { "Type",         colors.yellow,        nil },
    { "Structure",    colors.yellow,        nil },
    { "SpecialChar",  colors.purple,        nil },
    { "Deprecated",   nil,                  nil,                 styles.strikethrough },
    { "Bold",         nil,                  nil,                 styles.bold },
    { "Underlined",   nil,                  nil,                 styles.underline },
    { "FloatShadow",  nil,                  colors.background }
  }

  local highlights = {
    { "MiniIndentscopeSymbol",      { link = "Normal" } },
    { "CmpItemKindKeywordDefault",  { link = "Keyword" } },
    { "CmpItemKindMethodDefault",   { link = "Function" } },
    { "CmpItemKindModuleDefault",   { link = "Structure" } },
    { "CmpItemKindStructDefault",   { link = "Structure" } },
    { "CmpItemKindPropertyDefault", { link = "Identifier" } },
    { "CmpItemKindValueDefault",    { link = "Identifier" } },
    { "AlphaHeader",                { link = "Title" } },
    { "AlphaFooter",                { link = "Warn" } },
    { "DiagnosticDeprecated",       { link = "Deprecated" } },
    { "Statement",                  { link = "Identifier" } },
    { "Character",                  { link = "Identifier" } },
    { "PreProc",                    { link = "Identifier" } },
    { "@keyword.return",            { link = "Identifier" } },
    { "@variable",                  { link = "Normal" } },
    { "Number",                     { link = "Constant" } },
    { "DiagnosticInfo",             { link = "Info" } },
    { "DiagnosticWarn",             { link = "Warn" } },
    { "DiagnosticError",            { link = "Error" } },
    { "Removed",                    { link = "Error" } },
    { "Added",                      { link = "Success" } },
    { "ErrorMsg",                   { link = "Error" } },
    { "Float",                      { link = "Number" } },
    { "NormalNC",                   { link = "Normal" } },
    { "MsgArea",                    { link = "Background" } },
    { "Menu",                       { link = "Background" } },
    { "Scrollbar",                  { link = "Background" } },
    { "NeoTreeNormal",              { link = "Background" } },
    { "NeoTreeNormalNC",            { link = "Background" } },
    { "NeoTreeEndOfBuffer",         { link = "Background" } },
    { "Tooltip",                    { link = "Float" } },
    { "lCursor",                    { link = "Cursor" } },
    { "CursorIM",                   { link = "Cursor" } },
    { "TermCursor",                 { link = "Cursor" } },
    { "TermCursorNC",               { link = "Cursor" } },
    { "CursorColumn",               { link = "CursorLine" } },
    { "ColorColumn",                { link = "CursorLine" } },
    { "EndOfBuffer",                { link = "NonText" } },
    { "IncSearch",                  { link = "Search" } },
    { "CurSearch",                  { link = "Search" } },
    { "SatelliteSearch",            { link = "Search" } },
    { "Substitute",                 { link = "Search" } },
    { "SignColumn",                 { link = "LineNr" } },
    { "LineNrAbove",                { link = "LineNr" } },
    { "LineNrBelow",                { link = "LineNr" } },
    { "CursorLineSign",             { link = "CursorLine" } },
    { "CursorLineNr",               { link = "CursorLine" } },
    { "MsgSeparator",               { link = "WinSeparator" } },
    { "FloatBorder",                { link = "NormalFloat" } },
    { "FloatTitle",                 { link = "Title" } },
    { "FloatFooter",                { link = "FloatTitle" } },
    { "Pmenu",                      { link = "NormalFloat" } },
    { "PmenuKind",                  { link = "NormalFloat" } },
    { "PmenuExtra",                 { link = "NormalFloat" } },
    { "PmenuSel",                   { link = "Visual" } },
    { "PmenuKindSel",               { link = "Visual" } },
    { "PmenuExtraSel",              { link = "Visual" } },
    { "SnippetTabstop",             { link = "Visual" } },
    { "PmenuSbar",                  { link = "Normal" } },
    { "QuickFixLine",               { link = "CursorLine" } },
    { "SpecialKey",                 { link = "NonText" } },
    { "SpellBad",                   { link = "Underlined" } },
    { "SpellCap",                   { link = "SpellBad" } },
    { "SpellLocal",                 { link = "SpellBad" } },
    { "SpellRare",                  { link = "SpellBad" } },
    { "StatusLine",                 { link = "TabLine" } },
    { "StatusLineNC",               { link = "TabLine" } },
    { "TabLineFill",                { link = "TabLine" } },
    { "TabLineSel",                 { link = "TabLine" } },
    { "WinBar",                     { link = "TabLine" } },
    { "WinBarNC",                   { link = "TabLine" } },
    { "Whitespace",                 { link = "NonText" } },
    { "WildMenu",                   { link = "Search" } },
  }

  for _, group in ipairs(highlight_groups) do
    Group.new(unpack(group))
  end

  for _, highlight in ipairs(highlights) do
    vim.api.nvim_set_hl(0, unpack(highlight))
  end

  -- background = #16181d

  -- base16.setup({
  --   palette = {
  --     base00 = colors.black,         -- #282c34
  --     base01 = colors.darker_gray,   -- #353b45
  --     base02 = colors.dark_gray,     -- #3e4451
  --     base03 = colors.gray,          -- #545862
  --     base04 = colors.light_gray,    -- #565c64
  --     base05 = colors.lighter_gray,  -- #abb2bf
  --     base06 = colors.lightest_gray, -- #b6bdca
  --     base07 = colors.white,         -- #c8ccd4
  --     base08 = colors.red,           -- #e06c75
  --     base09 = colors.orange,        -- #d19a66
  --     base0A = colors.yellow,        -- #e5c07b
  --     base0B = colors.green,         -- #98c379
  --     base0C = colors.cyan,          -- #56b6c2
  --     base0D = colors.blue,          -- #61afef
  --     base0E = colors.purple,        -- #c678dd
  --     base0F = colors.magenta,       -- #be5046
  --   },
  --   use_cterm = true,
  --   plugins = { default = true }
  -- })


  -- local highlights = {
  -- { "t-Background",      { bg = colors.background } },
  -- { "t-LightBackground", { bg = colors.gray } },
  -- { "t-Active",          { bg = colors.blue, fg = colors.black } },
  -- { "t-Cursor",          { bg = colors.white, fg = colors.black } },
  --
  -- { "ColorColumn",       { link = "t-base-300" } },
  -- { "CurSearch",         { link = "t-Active" } },
  -- { "Cursor",            { link = "t-Cursor" } },
  -- { "lCursor",           { link = "t-Cursor" } },
  -- { "CursorIM",          { link = "t-Cursor" } },
  -- { "CursorColumn",      { link = "t-base-200" } },
  -- { "CursorLine",        { link = "t-base-200" } },

  -- { "AlphaFooter",           { fg = colors.yellow } },
  -- { "AlphaHeader",           { fg = colors.blue } },
  -- { "barbecue_normal",       { bg = colors.background } },
  -- { "BufferLineFill",        { bg = colors.background, fg = colors.background } },
  -- { "BufferLineSeparator",   { bg = colors.background } },
  -- { "CmpPmenu",              { bg = colors.black } },
  -- { "DapStoppedLine",        { default = true, link = "Visual" } },
  -- { "FloatBorder",           { fg = colors.light_gray } },
  -- { "FloatBorderCmp",        { fg = colors.light_gray } },
  -- { "FloatBorderDocs",       { fg = colors.blue } },
  -- { "GitSignsAdd",           { fg = colors.green } },
  -- { "GitSignsAddNr",         { fg = colors.green } },
  -- { "GitSignsChange",        { fg = colors.orange } },
  -- { "GitSignsChangeNr",      { fg = colors.orange } },
  -- { "GitSignsDelete",        { fg = colors.red } },
  -- { "GitSignsDeleteNr",      { fg = colors.red } },
  -- { "IlluminatedWordText",   { bg = colors.darker_gray } },
  -- { "IlluminatedWordRead",   { bg = colors.darker_gray } },
  -- { "IlluminatedWordWrite",  { bg = colors.darker_gray } },
  -- { "LineNr",                { bg = colors.black, fg = colors.light_gray } },
  -- { "LineNrAbove",           { bg = colors.black, fg = colors.light_gray } },
  -- { "LineNrBelow",           { bg = colors.black, fg = colors.light_gray } },
  -- { "NeoTreeNormal",         { bg = colors.background, fg = colors.lightest_gray } },
  -- { "NeoTreeNormalNC",       { bg = colors.background, fg = colors.lightest_gray } },
  -- { "NeoTreeWinSeparator",   { bg = colors.background } },
  -- { "MatchParen",            { fg = colors.lightest_gray, bg = colors.light_gray, bold = true } },
  -- { "MiniIndentscopeSymbol", { fg = colors.lighter_gray } },
  -- { "MiniMapSymbolLine",     { fg = colors.white } },
  -- { "MiniMapSymbolView",     { fg = colors.light_gray } },
  -- { "NormalFloat",           { bg = colors.black } },
  -- { "SatelliteBar",          { bg = colors.dark_gray } },
  -- { "SatelliteBackground",   { bg = colors.black } },
  -- { "SignColumn",            { bg = colors.black } },
  -- { "Structure",             { fg = colors.yellow } },
  -- { "SpecialChar",           { fg = colors.purple } },
  -- { "TelescopeBorder",       { fg = colors.lighter_gray } },
  -- { "WinSeparator",          { bg = colors.background } }
  -- }
end
