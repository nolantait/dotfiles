local settings = require("globals.settings")
local icons = require("globals.icons")
local clone_prefix = "https://github.com/%s.git"

return {
  defaults = {
    lazy = true
  },
  git = {
    timeout = 300,
    url_format = clone_prefix
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
  },
  root = settings.data_dir .. "/lazy/",
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.88, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
    icons = {
      cmd = icons.code,
      config = icons.gear,
      event = icons.event,
      ft = icons.files.new,
      init = icons.manup,
      import = icons.import,
      keys = icons.keyboard,
      loaded = icons.check,
      not_loaded = icons.ghost,
      plugin = icons.package,
      runtime = icons.vim,
      source = icons.source,
      start = icons.play,
      list = {
        icons.circle,
        icons.empty_circle,
        icons.square,
        icons.chevron_right,
      },
    },
  },
  performance = {
    cache = {
      enabled = true,
      path = settings.cache_dir .. "/lazy/cache",
      -- Once one of the following events triggers, caching will be disabled.
      -- To cache all modules, set this to `{}`, but that is not recommended.
      disable_events = { "UIEnter", "BufReadPre" },
      ttl = 3600 * 24 * 2, -- Keep unused modules for up to 2 days
    },
    reset_packpath = true, -- Reset the package path to improve startup time
    rtp = {
      reset = true,        -- Reset the runtime path to $VIMRUNTIME and the config directory
      paths = {},          -- Add any custom paths here that you want to include in the rtp
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      }
    }
  }
}
