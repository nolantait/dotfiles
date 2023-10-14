-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
vim.opt.rtp:prepend(lazypath)

-- Load settings
local settings = require("globals.settings")
local icons = require("globals.icons")
local clone_prefix = "https://github.com/%s.git"
local opts = {
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

local plugins = {
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = require("plugins.configs.trouble"),
  },
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    config = require("plugins.configs.neotest"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec"
    },
    -- ft = {
    --   "ruby"
    -- }
  },
  -- {
  --   "klen/nvim-test",
  --   config = require("plugins.configs.nvim-test"),
  --   ft = {
  --     "ruby"
  --   }
  -- },
  {
    "nolantait/mason-update-all",
    lazy = false,
    config = function()
      require("mason-update-all").setup()
    end
  },
  {
    "RRethy/nvim-base16",
    config = require("plugins.configs.colorscheme"),
    lazy = false,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    event = "BufReadPre",
  },
  {
    "tpope/vim-rails",
    config = require("plugins.configs.rails"),
    ft = {
      "ruby",
      "erb",
    },
    event = "BufReadPre",
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = require("plugins.configs.notify"),
  },
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    config = require("plugins.configs.wilder"),
    dependencies = {
      "romgrk/fzy-lua-native",
    },
  },
  {
    "nvimdev/hlsearch.nvim",
    event = "BufReadPost"
  },
  {
    "jghauser/mkdir.nvim",
    event = "BufReadPre",
  },
  {
    "stevearc/dressing.nvim",
    config = require("plugins.configs.dressing"),
    event = "BufReadPre",
  },
  {
    "tpope/vim-commentary",
    event = "BufReadPost",
  },
  {
    "utilyre/barbecue.nvim",
    config = require("plugins.configs.barbecue"),
    event = "BufReadPost",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    version = "*",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = require("plugins.configs.indent-blankline")
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = require("plugins.configs.telescope"),
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      },
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      if #vim.api.nvim_list_uis() ~= 0 then
        vim.api.nvim_command("TSUpdate")
      end
    end,
    config = require("plugins.configs.treesitter"),
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "p00f/nvim-ts-rainbow",
      "windwp/nvim-ts-autotag",
      {
        "andymass/vim-matchup",
        config = require("plugins.configs.matchup"),
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = require("plugins.configs.treesitter-context")
      },
      {
        "NvChad/nvim-colorizer.lua",
        lazy = false,
        config = require("plugins.configs.colorizer"),
      }
    },
    event = "BufReadPost",
  },
  {
    "RRethy/vim-illuminate",
    config = require("plugins.configs.illuminate"),
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    event = { "CursorHold", "CursorHoldI" },
  },
  {
    "famiu/bufdelete.nvim",
    cmd = { "BufDel", "BufDelAll", "BufDelOthers" }
  },
  {
    "LunarVim/bigfile.nvim",
    lazy = false,
    config = require("plugins.configs.bigfile"),
  },
  {
    "neovim/nvim-lspconfig",
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.configs.lsp"),
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim"
    },
  },
  {
    "hrsh7th/nvim-cmp", -- Snippet support
    lazy = true,
    event = "InsertEnter",
    config = require("plugins.configs.cmp"),
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        config = require("plugins.configs.luasnip"),
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "2.*",
      },
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "andersevenrud/cmp-tmux",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-buffer",
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = require("plugins.configs.copilot"),
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = require("plugins.configs.copilot-cmp"),
      },
    },
  },
  {
    "mtdl9/vim-log-highlighting",
    ft = {
      "text",
      "txt",
      "log"
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = require("plugins.configs.neo-tree"),
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
      "NvimTreeRefresh",
    },
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",        -- improved UI components
    },
    lazy = false,
  },
  {
    "folke/which-key.nvim",
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.configs.which-key"),
  },
  {
    "mfussenegger/nvim-dap",
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    config = require("plugins.configs.dap"),
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "suketa/nvim-dap-ruby",
      {
        "rcarriga/nvim-dap-ui",
        config = require("plugins.configs.dap.dapui"),
      },
    },
  },
  {
    "goolord/alpha-nvim",
    event = "BufWinEnter",
    config = require("plugins.configs.alpha"),
  },
  {
    "akinsho/bufferline.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require("plugins.configs.bufferline")
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = require("plugins.configs.fidget"),
    tag = "legacy",
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.configs.gitsigns")
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    config = require("plugins.configs.indent-blankline")
  },
  {
    "hoob3rt/lualine.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require("plugins.configs.lualine")
  },
  {
    "petertriho/nvim-scrollbar",
    config = require("plugins.configs.scrollbar"),
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      {
        "lewis6991/gitsigns.nvim",
        config = require("plugins.configs.gitsigns")
      },
    },
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
  {
    "edluffy/specs.nvim",
    event = "CursorMoved",
    config = require("plugins.configs.specs")
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = require("plugins.configs.todo-comments"),
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  }
}

require("lazy").setup(plugins, opts)
