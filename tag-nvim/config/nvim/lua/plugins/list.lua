-- DOCS: This is where we define our plugins which will get loaded in the
-- background when needed by lazy.nvim
--
-- Typical execution would go in the following order:
-- 1. Lazy false (by priority)
-- 2. Events when they fire
--  - VimEnter
--  - LazyFile (see plugins/init.lua)
--  - CursorHold/CursorHoldI
--  - CursorMoved
--  - InsertEnter
--  - LspAttach
-- 3. By cmd option
-- 4. By filetype
--
-- Plugins are grouped into locals and then merged into the full list:
--
-- local high_priority
-- local custom
-- local events
-- local commands
-- local filetypes
-- local very_lazy

local settings = require("globals.settings")
local plugins = require("plugins")
local keymap = plugins.convert_keymap

local high_priority = {
  {
    "echasnovski/mini.sessions",
    config = require("plugins.configs.mini-sessions"),
    keys = keymap(require("plugins.keybinds.mini-sessions")),
    lazy = false,
  },
  {
    -- Unload plugins when opening large files
    "LunarVim/bigfile.nvim",
    config = require("plugins.configs.bigfile"),
    lazy = false,
  },
  {
    "m4xshen/hardtime.nvim",
    config = require("plugins.configs.hardtime"),
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = require("plugins.configs.snacks"),
    keys = keymap(require("plugins.keybinds.snacks")),
  },
}

local custom = {
  {
    "rktjmp/lush.nvim",
    lazy = false,
  },
  {
    config = require("plugins.configs.colorscheme"),
    priority = 1000,
    dir = settings.vim_path .. "/custom_plugins/colorscheme.nvim",
    lazy = false,
  },
  {
    config = true,
    dir = settings.vim_path .. "/custom_plugins/profiling.nvim",
    lazy = false,
    enabled = false,
  },
  {
    config = true,
    ft = "ruby",
    dir = settings.vim_path .. "/custom_plugins/gem.nvim",
  },
}

local events = {
  {
    "sphamba/smear-cursor.nvim",
    config = require("plugins.configs.smear-cursor"),
    event = "CursorMoved",
  },
  {
    -- Startup dashboard greeting when opening vim
    "goolord/alpha-nvim",
    config = require("plugins.configs.alpha"),
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VimEnter",
  },
  {
    "joshuavial/aider.nvim",
    enabled = false,
    keys = keymap(require("plugins.keybinds.aider")),
    config = require("plugins.configs.aider"),
  },
  {
    "yetone/avante.nvim",
    enabled = true,
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    config = require("plugins.configs.avante"),
    keys = keymap(require("plugins.keybinds.avante")),
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    cmd = {
      "AvanteAsk",
      "AvanteBuild",
      "AvanteChat",
      "AvanteClear",
      "AvanteEdit",
      "AvanteFocus",
      "AvanteHistory",
      "AvanteModels",
      "AvanteRefresh",
      "AvanteShowRepoMap",
      "AvanteStop",
      "AvanteSwitchFileSectorProvider",
      "AvanteSwitchProvider",
      "AvanteToggle",
      "AvanteToggle",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        config = require("plugins.configs.render-markdown"),
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          float_win_config = {
            border = require("core.utils").border("FloatBorder"),
          },
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    config = require("plugins.configs.lsp"),
    keys = keymap(require("plugins.keybinds.lsp")),
    lazy = false,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = keymap(require("plugins.keybinds.conform")),
    config = require("plugins.configs.conform"),
  },
  {
    -- Auto remove search highlight and rehighlight when using n or N
    "nvimdev/hlsearch.nvim",
    config = true,
    event = "LazyFile",
  },
  {
    -- Automatically make new directories when saving a file
    "jghauser/mkdir.nvim",
    event = "LazyFile",
  },
  {
    "MagicDuck/grug-far.nvim",
    config = require("plugins.configs.grug-far"),
    keys = keymap(require("plugins.keybinds.grug-far")),
    cmd = { "GrugFar" },
    event = "LazyFile",
  },
  {
    -- Automatic commenting with gc
    "echasnovski/mini.comment",
    config = require("plugins.configs.mini-comment"),
    event = "LazyFile",
  },
  {
    -- Breadcrumbs for your code in the top of the buffer
    "utilyre/barbecue.nvim",
    config = require("plugins.configs.barbecue"),
    event = "LazyFile",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    version = "*",
  },
  {
    -- Buffer tabs at the top of screen
    "akinsho/bufferline.nvim",
    branch = "main",
    -- Waiting for https://github.com/akinsho/bufferline.nvim/pull/896
    commit = "73540cb",
    config = require("plugins.configs.bufferline"),
    event = "LazyFile",
  },
  {
    -- Powerline at the bottom of screen
    "hoob3rt/lualine.nvim",
    config = require("plugins.configs.lualine"),
    event = "LazyFile",
    dependencies = {
      "AndreM222/copilot-lualine",
    },
  },
  {
    -- Todo comment highlighting
    "folke/todo-comments.nvim",
    config = require("plugins.configs.todo-comments"),
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "LazyFile",
  },
  {
    "echasnovski/mini.surround",
    config = require("plugins.configs.mini-surround"),
    event = "LazyFile",
  },
  {
    "echasnovski/mini.splitjoin",
    config = require("plugins.configs.mini-splitjoin"),
    event = "LazyFile",
  },
  {
    "echasnovski/mini.pairs",
    config = require("plugins.configs.mini-pairs"),
    lazy = false,
  },
  {
    "echasnovski/mini.move",
    config = require("plugins.configs.mini-move"),
    event = "LazyFile",
  },
  {
    "nolantait/mini.map",
    enabled = false,
    config = require("plugins.configs.mini-map"),
    event = "LazyFile",
    keys = keymap(require("plugins.keybinds.mini-map")),
  },
  {
    -- Highlighting of the word under the cursor
    "RRethy/vim-illuminate",
    config = require("plugins.configs.illuminate"),
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CursorHold", "CursorHoldI" },
  },
  {
    -- Git decorations in the gutter
    "lewis6991/gitsigns.nvim",
    config = require("plugins.configs.gitsigns"),
    event = { "CursorHold", "CursorHoldI" },
  },
  {
    -- Auto completion using Github's copilot
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    config = require("plugins.configs.copilot"),
    keys = keymap(require("plugins.keybinds.copilot")),
    event = "InsertEnter",
    dependencies = {
      {
        -- We will be loading this inside of the cmp config
        "zbirenbaum/copilot-cmp",
      },
    },
  },
  {
    -- Show keymaps on partial completion at the bottom of the screen
    "echasnovski/mini.clue",
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.configs.mini-clue"),
  },
  {
    -- Tab completions with suggestions from many sources (copilot, lsp, etc)
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = require("plugins.configs.cmp"),
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "andersevenrud/cmp-tmux",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
    },
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = true,
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
  },
  {
    -- Completions for vim commands and paths
    "folke/noice.nvim",
    config = require("plugins.configs.noice"),
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    event = "CmdlineEnter",
  },
  {
    -- LSP loading popup on bottom right
    "j-hui/fidget.nvim",
    config = require("plugins.configs.fidget"),
    event = "LspAttach",
    tag = "legacy",
  },
  {
    "andymass/vim-matchup",
    config = require("plugins.configs.matchup"),
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = require("plugins.configs.highlight-colors"),
    event = "LazyFile",
  },
  {
    "uga-rosa/ccc.nvim",
    config = require("plugins.configs.ccc"),
    keys = keymap(require("plugins.keybinds.ccc")),
    event = "LazyFile",
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "LazyFile",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = require("plugins.configs.treesitter-context"),
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "LazyFile",
  },
  {
    -- Improved syntax highlighting and code understanding for other plugins
    "nvim-treesitter/nvim-treesitter",
    config = require("plugins.configs.treesitter"),
    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSBufToggle",
      "TSDisable",
      "TSEnable",
      "TSToggle",
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSModuleInfo",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    -- Disabling lazy loading so new files work without error
    lazy = "LazyFile",
  },
  {
    "lewis6991/satellite.nvim",
    config = require("plugins.configs.satellite"),
    event = "LazyFile",
  },
}

local commands = {
  {
    "akinsho/toggleterm.nvim",
    config = require("plugins.configs.toggleterm"),
    keys = keymap(require("plugins.keybinds.toggleterm")),
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
    },
    ft = { "sql", "mysql", "plsql" },
  },
  {
    "RubixDev/mason-update-all",
    cmd = "MasonUpdateAll",
    -- Use the default calling of require(MAIN).setup(opts) which in this case
    -- would call .setup({})
    config = true,
  },
  {
    "stevearc/aerial.nvim",
    config = require("plugins.configs.aerial"),
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = keymap(require("plugins.keybinds.aerial")),
  },
  {
    -- Prettier quickfix list
    "folke/trouble.nvim",
    -- Only load upon the usage of these commands
    keys = keymap(require("plugins.keybinds.trouble")),
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = require("plugins.configs.trouble"),
  },
  {
    -- Frecency search for telescope
    "nvim-telescope/telescope-frecency.nvim",
    cmd = "Telescope frecency",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    -- Fuzzy file searching
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = require("plugins.configs.telescope"),
    keys = keymap(require("plugins.keybinds.telescope")),
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
  },
  {
    -- Debug Adapter Protocol setup for interactive debugging
    "mfussenegger/nvim-dap",
    keys = keymap(require("plugins.keybinds.dap")),
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
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    opts = { virt_text_pos = "eol" },
  },
  {
    "rcarriga/nvim-dap-ui",
    config = require("plugins.configs.dap.dapui"),
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },
  {
    -- Filesystem tree on the left side of the screen
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    config = require("plugins.configs.neo-tree"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim", -- improved UI components
    },
    keys = keymap(require("plugins.keybinds.neo-tree")),
  },
}

local filetypes = {
  {
    "folke/lazydev.nvim",
    config = require("plugins.configs.lazydev"),
    dependencies = {
      "Bilal2453/luvit-meta",
      "hrsh7th/nvim-cmp",
    },
    ft = { "lua" },
  },
  {
    -- Colored log highlighting
    "mtdl9/vim-log-highlighting",
    ft = {
      "text",
      "txt",
      "log",
    },
  },
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
  },
}

local very_lazy = {
  {
    -- Better UI elements for neovim
    "stevearc/dressing.nvim",
    config = require("plugins.configs.dressing"),
    event = "VeryLazy",
    init = function()
      -- Init functions are always executed during startup.
      -- We can use this to override the default vim.ui functions
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      -- vim.ui.input = function(...)
      --   require("lazy").load({ plugins = { "dressing.nvim" } })
      --   return vim.ui.input(...)
      -- end
    end,
  },
  {
    -- Test runner
    "nvim-neotest/neotest",
    config = require("plugins.configs.neotest"),
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
      "nvim-neotest/neotest-python",
    },
    event = "VeryLazy",
    keys = keymap(require("plugins.keybinds.neotest")),
  },
}

return {
  high_priority,
  custom,
  events,
  commands,
  filetypes,
  very_lazy,
}
