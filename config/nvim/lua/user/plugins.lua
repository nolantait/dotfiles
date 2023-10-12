local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  git = { clone_timeout = 600 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "lukas-reineke/indent-blankline.nvim" -- Guides on left for indentation

  -- Telescope fuzzy searching
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
      },
      {
        "nvim-telescope/telescope-frecency.nvim"
      }
    }
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "p00f/nvim-ts-rainbow",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring"
    }
  }
  use "nvim-treesitter/playground"
  use "nvim-treesitter/nvim-treesitter-context" -- Show context of current function
  use "RRethy/vim-illuminate" -- Highlight other uses of the word under cusror

  -- UI
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "kyazdani42/nvim-web-devicons" -- Webdev icons
  use "MunifTanjim/nui.nvim" -- UI Components for other libs
  use "stevearc/dressing.nvim" -- Extend UI components
  use {
    "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim", -- improved UI components
      }
  }
  use "nvim-lualine/lualine.nvim" -- Statusline at bottom of the screen
  use {
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
  }
  use "goolord/alpha-nvim" -- Vim greeter
  use "folke/which-key.nvim" -- Display possible keybinds of commands you start typing

  -- Buffers
  use "famiu/bufdelete.nvim" -- Alternative BDelete that preserves layout
  use {
    "akinsho/bufferline.nvim", -- Bufferline at the top of the screen
    requires = {
      "nvim-tree/nvim-web-devicons"
    }
  }
  use "moll/vim-bbye"  -- Close buffers individually

  -- General
  use "vim-test/vim-test" -- Run test files with <leader>s and <leader>t
  use "tpope/vim-commentary" -- Comments with gc
  use "jghauser/mkdir.nvim" -- Make a directory when saving a file
  use "andymass/vim-matchup" -- Matchup for better % context navigation
  use {
    "nvimdev/hlsearch.nvim",
    event = "BufRead",
    config = function()
      require("hlsearch").setup()
    end
  }
  use "LunarVim/bigfile.nvim" -- Open large files faster

  -- Colorschemes
  use "RRethy/nvim-base16" -- Base 16 colorscheme
  use "norcalli/nvim-colorizer.lua"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "hrsh7th/cmp-nvim-lsp" -- lsp completions
  use {
    "L3MON4D3/LuaSnip", -- Snippets support
    version = "2.*",
    run = "make install_jsregexp"
  }
  use "saadparwaiz1/cmp_luasnip" -- Snippets support with cmp
  use "rafamadriz/friendly-snippets" -- Collection of snippets

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- LSP installer
  use "williamboman/mason-lspconfig.nvim" -- Support for lspconfig with mason

  -- Languages
  use "vim-crystal/vim-crystal"
  use "vim-ruby/vim-ruby"
  use "jlcrochet/vim-rbs"
  use "tpope/vim-rails" -- Rails helpers like :A for alt files
  use {
    "elixir-tools/elixir-tools.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim"
    }
  }
  use "rust-lang/rust.vim"
  use "simrat39/rust-tools.nvim"

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Copilot
  use "zbirenbaum/copilot.lua"
  use "zbirenbaum/copilot-cmp"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
