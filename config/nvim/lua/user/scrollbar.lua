local ok, scrollbar = prequire("scrollbar")
if not ok then
  return
end

if scrollbar then
  local colors = require("user.colors")

  scrollbar.setup({
    show = true,
    show_in_active_only = false,
    set_highlights = true,
    folds = 1000,  -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
    max_lines = 500, -- disables if no. of lines in buffer exceeds this
    handle = {
      text = " ",
      color = colors.dark_gray,
      hide_if_all_visible = true, -- Hides handle if all lines are visible
    },
    marks = {
      Search = {
        text = { "*", "=" },
        priority = 0,
        color = colors.yellow,
      },
      Error = {
        text = { "-", "=" },
        priority = 1,
        color = colors.red,
      },
      Warn = {
        text = { "-", "=" },
        priority = 2,
        color = colors.orange,
      },
      Info = {
        text = { "-", "=" },
        priority = 3,
        color = colors.blue,
      },
      Hint = {
        text = { "-", "=" },
        priority = 4,
        color = colors.green,
      },
      Misc = {
        text = { "-", "=" },
        priority = 5,
        color = colors.purple,
      },
      GitAdd = {
        text = "┆",
        priority = 7,
        color = nil,
        cterm = nil,
        highlight = "GitSignsAdd",
      },
      GitChange = {
        text = "┆",
        priority = 7,
        color = nil,
        cterm = nil,
        highlight = "GitSignsChange",
      },
      GitDelete = {
        text = "▁",
        priority = 7,
        color = nil,
        cterm = nil,
        highlight = "GitSignsDelete",
      },
    },
    excluded_buftypes = {
      "terminal",
    },
    excluded_filetypes = {
      "prompt",
      "TelescopePrompt",
      "noice",
    },
    autocmd = {
      render = {
        "BufWinEnter",
        "TabEnter",
        "TermEnter",
        "WinEnter",
        "CmdwinLeave",
        "TextChanged",
        "VimResized",
        "WinScrolled",
      },
      clear = {
        "BufWinLeave",
        "TabLeave",
        "TermLeave",
        "WinLeave",
      },
    },
    handlers = {
      cursor = true,
      diagnostic = true,
      gitsigns = true, -- Requires gitsigns
      handle = true,
      search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
    },
  })

  require("gitsigns").setup()
  require("scrollbar.handlers.gitsigns").setup()
end
