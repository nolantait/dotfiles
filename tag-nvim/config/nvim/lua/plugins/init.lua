-- DOCS: This file gets loaded by init.lua in the root folder and is the main
-- entrypoint for our plugins setup which uses lazy.nvim to load our plugins on
-- demand and in the background to improve the performance of our editor.

local settings = require("globals.settings")
local icons = require("globals.icons")

local M = {
  options = {
    defaults = {
      lazy = true
    },
    dev = {
      path = settings.vim_path .. "/lua/custom",
      fallback = false -- fallback to git when local plugins don't exist
    },
    git = {
      timeout = 300,
      url_format = "https://github.com/%s.git"
    },
    install = {
      -- install missing plugins on startup. This doesn't increase startup time.
      missing = true,
    },
    root = settings.data_dir .. "/lazy/",
    lockfile = settings.data_dir .. "/lazy/lazy-lock.json",
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
}

local install_lazy = function()
  -- Install lazy.nvim
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  vim.opt.rtp:prepend(lazypath)
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
end

local install_events = function()
  local events = require("lazy.core.handler.event")
  -- Sets up LazyFile event as a catchall for file events
  events.mappings.LazyFile = {
    id = "LazyFile",
    event = {
      "BufReadPost",
      "BufNewFile",
      "BufWritePre"
    }
  }
end

local load_plugins = function()
  -- Load settings and list of plugins
  local plugins = require("plugins.list")
  require("lazy").setup(plugins, M.options)
end

function M.convert_keymap(keybinds)
  local result = {}

  for _, keybind in ipairs(keybinds) do
    table.insert(result, {
      keybind.key,
      keybind.command,
      keybind.mode,
      desc = keybind.description,
      noremap = true,
      silent = true
    })
  end

  return result
end

function M.setup()
  install_lazy()
  install_events()
  load_plugins()
end

return M
