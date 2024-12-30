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
    lazy = false
  },
  {
    -- Unload plugins when opening large files
    "LunarVim/bigfile.nvim",
    config = require("plugins.configs.bigfile"),
    lazy = false,
  },
  {
    "mrcjkb/rustaceanvim",
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
  }
}

local custom = {
  {
    "stevearc/profile.nvim",
    enabled = true,
    lazy = false,
    config = require("plugins.configs.profiler")
  },
  {
    "rktjmp/lush.nvim",
    lazy = false,
  },
  {
    config = true,
    dir = settings.vim_path .. "/lua/custom",
    lazy = false,
    main = "custom.colorscheme",
    name = "custom.colorscheme"
  },
  {
    config = true,
    enabled = false,
    dir = settings.vim_path .. "/lua/custom",
    lazy = false,
    main = "custom.profiling",
    name = "custom.profiling",
  },
  {
    config = true,
    dir = settings.vim_path .. "/lua/custom",
    lazy = false,
    main = "custom.hardmode",
    name = "custom.hardmode",
  },
  {
    config = true,
    dir = settings.vim_path .. "/lua/custom",
    lazy = false,
    main = "custom.gem",
    name = "custom.gem",
  },
}

local events = {
  {
    -- Startup dashboard greeting when opening vim
    "goolord/alpha-nvim",
    config = require("plugins.configs.alpha"),
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    event = "VimEnter",
  },
  {
    -- Setting up LSP servers for neovim
    "neovim/nvim-lspconfig",
    config = require("plugins.configs.lsp"),
    event = { "BufReadPre", "BufNewFile" },
    cmd = {
      "Mason"
    },
    keys = keymap(require("plugins.keybinds.lsp")),
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = keymap(require("plugins.keybinds.conform")),
    config = require("plugins.configs.conform")
  },
  {
    -- Auto remove search highlight and rehighlight when using n or N
    "nvimdev/hlsearch.nvim",
    config = true,
    event = "LazyFile"
  },
  {
    -- Automatically make new directories when saving a file
    "jghauser/mkdir.nvim",
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
    -- Indentations on left side of lines
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    config = require("plugins.configs.indent-blankline"),
    event = "LazyFile",
    main = "ibl",
  },
  {
    -- Powerline at the bottom of screen
    "hoob3rt/lualine.nvim",
    config = require("plugins.configs.lualine"),
    event = "LazyFile",
    dependencies = {
      "AndreM222/copilot-lualine"
    }
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
    event = "LazyFile"
  },
  {
    "echasnovski/mini.splitjoin",
    config = require("plugins.configs.mini-splitjoin"),
    event = "LazyFile"
  },
  {
    "echasnovski/mini.pairs",
    config = require("plugins.configs.mini-pairs"),
    lazy = false
  },
  {
    "echasnovski/mini.move",
    config = require("plugins.configs.mini-move"),
    event = "LazyFile"
  },
  {
    "nolantait/mini.map",
    enabled = false,
    config = require("plugins.configs.mini-map"),
    event = "LazyFile",
    keys = keymap(require("plugins.keybinds.mini-map")),
  },
  {
    "echasnovski/mini.indentscope",
    config = require("plugins.configs.mini-indentscope"),
    event = "LazyFile"
  },
  {
    -- Highlighting of the word under the cursor
    "RRethy/vim-illuminate",
    config = require("plugins.configs.illuminate"),
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
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
        "zbirenbaum/copilot-cmp"
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
    main = require("utils.cmp"),
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "andersevenrud/cmp-tmux",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-buffer"
    },
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = true,
    dependencies = {
      "hrsh7th/nvim-cmp",
    }
  },
  {
    -- Completions for vim commands and paths
    "gelguy/wilder.nvim",
    config = require("plugins.configs.wilder"),
    dependencies = {
      "romgrk/fzy-lua-native",
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
    }
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = require("plugins.configs.highlight-colors"),
    event = "LazyFile"
  },
  {
    "uga-rosa/ccc.nvim",
    config = require("plugins.configs.ccc"),
    keys = keymap(require("plugins.keybinds.ccc")),
    event = "LazyFile"
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "LazyFile"
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
    -- Delete buffers individually, fixes some of vim's quirks
    "echasnovski/mini.bufremove",
    config = true,
    event = "LazyFile",
    keys = keymap(require("plugins.keybinds.bufremove"))
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
    lazy = "LazyFile"
  },
  {
    "lewis6991/satellite.nvim",
    config = require("plugins.configs.satellite"),
    event = "LazyFile",
  }
}

local commands = {
  {
    "akinsho/toggleterm.nvim",
    config = require("plugins.configs.toggleterm"),
    cmd = {
      "ToggleTerm",
      "TermExec",
      "ToggleTermToggleAll",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
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
    -- Custom fork of mason-update-all which uses notifications instead of print
    "nolantait/mason-update-all",
    cmd = "MasonUpdateAll",
    -- Use the default calling of require(MAIN).setup(opts) which in this case
    -- would call .setup({})
    config = true,
    dependencies = {
      "neovim/nvim-lspconfig",
    }
  },
  {
    'stevearc/aerial.nvim',
    config = require("plugins.configs.aerial"),
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
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
    config = function()
      require("telescope").load_extension "frecency"
    end
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
        build = "make"
      },
    }
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
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true
      },
      {
        "rcarriga/nvim-dap-ui",
        config = require("plugins.configs.dap.dapui"),
      },
    },
  },
  {
    -- Filesystem tree on the left side of the screen
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    config = require("plugins.configs.neo-tree"),
    cmd = {
      "Neotree",
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
      "NvimTreeRefresh",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",        -- improved UI components
    },
    keys = keymap(require("plugins.keybinds.neo-tree")),
  },
}

local filetypes = {
  {
    -- Easier navigation through rails apps with shortcuts
    "tpope/vim-rails",
    config = require("plugins.configs.rails"),
    ft = {
      "ruby",
      "eruby",
    },
  },
  {
    "folke/lazydev.nvim",
    config = require("plugins.configs.lazydev"),
    dependencies = {
      "Bilal2453/luvit-meta",
      "hrsh7th/nvim-cmp"
    },
    ft = { "lua" },
  },
  {
    -- Colored log highlighting
    "mtdl9/vim-log-highlighting",
    ft = {
      "text",
      "txt",
      "log"
    }
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
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end
  },
  {
    -- Popup notifications on the top right of the screen
    "rcarriga/nvim-notify",
    config = require("plugins.configs.notify"),
    keys = keymap(require("plugins.keybinds.notify")),
    -- Load later, after everything else, not important for initial UI paint
    event = "VeryLazy",
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
      "nvim-neotest/neotest-python"
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
  very_lazy
}
