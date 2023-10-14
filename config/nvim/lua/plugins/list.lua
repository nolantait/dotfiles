return {
  {
    -- Prettier quickfix list
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = require("plugins.configs.trouble"),
  },
  {
    -- Test runner
    "nvim-neotest/neotest",
    event = "VeryLazy",
    config = require("plugins.configs.neotest"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec"
    },
  },
  {
    -- Custom fork of mason-update-all which uses notifications instead of print
    "nolantait/mason-update-all",
    lazy = false,
    -- Use the default calling of require(MAIN).setup(opts) which in this case
    -- would call .setup({})
    config = true
  },
  {
    -- Base16 colorscheme controlled with flavours in globals/colors.lua
    "RRethy/nvim-base16",
    config = require("plugins.configs.colorscheme"),
    lazy = false,
    -- Load before everything else, default is 50
    priority = 1000
  },
  {
    -- Rust integration with LSP
    "simrat39/rust-tools.nvim",
    -- Load only when opening a rust file
    ft = "rust",
    event = "BufReadPre",
  },
  {
    -- Easier navigation through rails apps with shortcuts
    "tpope/vim-rails",
    config = require("plugins.configs.rails"),
    ft = {
      "ruby",
      "erb",
    },
    event = "BufReadPre",
  },
  {
    -- Popup notifications on the top right of the screen
    "rcarriga/nvim-notify",
    -- Load later, after everything else, not important for initial UI paint
    event = "VeryLazy",
    config = require("plugins.configs.notify"),
  },
  {
    -- Completions for vim commands and paths
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    config = require("plugins.configs.wilder"),
    dependencies = {
      "romgrk/fzy-lua-native",
    },
  },
  {
    -- Highlight search results and make navigation easier
    "nvimdev/hlsearch.nvim",
    event = "BufReadPost"
  },
  {
    -- Automatically make new directories when saving a file
    "jghauser/mkdir.nvim",
    event = "BufReadPre",
  },
  {
    -- Better UI elements for neovim
    "stevearc/dressing.nvim",
    config = require("plugins.configs.dressing"),
    event = "BufReadPre",
  },
  {
    -- Automatic commenting with gc
    "tpope/vim-commentary",
    event = "BufReadPost",
  },
  {
    -- Breadcrumbs for your code in the top of the buffer
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
    -- Fuzzy file searching
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
    -- Improved syntax highlighting and code understanding for other plugins
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
    -- Highlighting of the word under the cursor
    "RRethy/vim-illuminate",
    config = require("plugins.configs.illuminate"),
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    event = { "CursorHold", "CursorHoldI" },
  },
  {
    -- Delete buffers individually, fixes some of vim's quirks
    "famiu/bufdelete.nvim",
    cmd = { "BufDel", "BufDelAll", "BufDelOthers" }
  },
  {
    -- Unload plugins when opening large files
    "LunarVim/bigfile.nvim",
    lazy = false,
    config = require("plugins.configs.bigfile"),
  },
  {
    -- Setting up LSP servers for neovim
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
    -- Tab completions with suggestions from many sources (copilot, lsp, etc)
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    config = require("plugins.configs.cmp"),
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
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
    -- Auto completion using Github's copilot
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = require("plugins.configs.copilot"),
    dependencies = {
      {
        -- We will be loading this inside of the cmp config
        "zbirenbaum/copilot-cmp"
      },
    },
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
  {
    -- Filesystem tree on the left side of the screen
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
    -- Show keymaps on partial completion at the bottom of the screen
    "folke/which-key.nvim",
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.configs.which-key"),
  },
  {
    -- Debug Adapter Protocol setup for interactive debugging
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
    -- Startup dashboard greeting when opening vim
    "goolord/alpha-nvim",
    event = "BufWinEnter",
    config = require("plugins.configs.alpha"),
  },
  {
    -- Buffer tabs at the top of screen
    "akinsho/bufferline.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require("plugins.configs.bufferline")
  },
  {
    -- LSP loading popup on bottom right
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = require("plugins.configs.fidget"),
    tag = "legacy",
  },
  {
    -- Git decorations in the gutter
    "lewis6991/gitsigns.nvim",
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.configs.gitsigns")
  },
  {
    -- Indentations on left side of lines
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    config = require("plugins.configs.indent-blankline")
  },
  {
    -- Powerline at the bottom of screen
    "hoob3rt/lualine.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require("plugins.configs.lualine")
  },
  {
    -- Scrollbar on right side of bufffer
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
    -- Animated cursor movements
    "edluffy/specs.nvim",
    event = "CursorMoved",
    config = require("plugins.configs.specs")
  },
  {
    -- Todo comment highlighting
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = require("plugins.configs.todo-comments"),
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  }
}
