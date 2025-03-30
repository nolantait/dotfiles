local M = {
  globals = {
    --Remap space as leader key
    mapleader = " ",
    maplocalleader = " ",
    -- Disable providers
    loaded_perl_provider = 0,
    loaded_ruby_provider = 0,
    loaded_python3_provider = 0,
    loaded_node_provider = 0,
    -- Disable menu loading
    did_install_default_menus = 1,
    did_install_syntax_menu = 1,
    -- Uncomment this if you define your own filetypes in `after/ftplugin`
    -- g.did_load_filetypes = 1
    -- Do not load native syntax completion
    loaded_syntax_completion = 1,
    -- Do not load spell files
    loaded_spellfile_plugin = 1,
    -- Do not load netrw by default
    loaded_netrw = 1,
    loaded_netrwFileHandlers = 1,
    loaded_netrwPlugin = 1,
    loaded_netrwSettings = 1,
    -- Do not load tohtml.vim
    loaded_2html_plugin = 1,
    -- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
    -- related to checking files inside compressed files)
    loaded_gzip = 1,
    loaded_tar = 1,
    loaded_tarPlugin = 1,
    loaded_vimball = 1,
    loaded_vimballPlugin = 1,
    loaded_zip = 1,
    loaded_zipPlugin = 1,
    -- Disable sql omni completion.
    loaded_sql_completion = 1,
    -- Disable EditorConfig support
    editorconfig = 1,
    -- Disable remote plugins
    loaded_remote_plugins = 1, -- Disable menu loading
    -- Disable markdown folding
    vim_markdown_folding_disabled = 1,
    -- Fenced languages syntax highlight in markdown
    vim_markdown_fenced_languages = {
      "c==cpp",
      "viml=vim",
      "bash=sh",
      "ini=dosini",
      "py=python",
      "rb=ruby",
      "ruby",
    },
    -- Highlight YAML/TOML/JSON front matter.
    vim_markdown_frontmatter = true,
    -- Strikethrough uses two tildes.
    vim_markdown_strikethrough = true,
    rust_recommended_style = 1,
    inlay_hints = true,
  },
  options = {
    backup = false, -- Prevents creating a backup file
    backspace = "2", -- Backspace deletes like most programs in insert mode
    breakindent = true, -- Wrap indent to match line start
    clipboard = vim.env.SSH_TTY and "" or "unnamedplus", -- Allows neovim to access the system clipboard
    cmdheight = 0, -- More space in the neovim command line for displaying messages
    completeopt = { "menu", "menuone", "noselect" }, -- Mostly just for cmp
    copyindent = true, -- Copy the previous indentation on autoindenting
    conceallevel = 0, -- So that `` is visible in markdown files
    colorcolumn = "+1", -- Highlight the 80th column
    cursorline = true, -- Highlight the current line
    expandtab = true, -- Convert tabs to spaces
    fileencoding = "utf-8", -- The encoding written to a file
    fileformats = "unix,dos,mac", -- Prefer UNIX over Windows
    fillchars = { -- Set fillchars
      foldopen = "",
      foldclose = "",
      fold = " ",
      foldsep = " ",
      diff = "╱",
      eob = " ",
      msgsep = "─",
    },
    formatoptions = "qjl1", -- Don't auto format comments
    grepprg = "rg --vimgrep", -- Use ripgrep for grepping
    grepformat = "%f:%l:%c:%m", -- Ripgrep format
    history = 100, -- Number of commands to remember in a history table
    hlsearch = true, -- Highlight all matches on previous search pattern
    ignorecase = true, -- Ignore case in search patterns
    incsearch = true, -- Show search matches as you type
    infercase = true, -- Infer cases in keyword completion
    joinspaces = false, -- One space after punctuation
    jumpoptions = "stack,view", -- Jump to the last known position when opening a file
    laststatus = 0, -- Global status
    linebreak = true, -- Wrap lines at 'breakat'
    list = true, -- Show some invisible characters
    listchars = { tab = "»·", trail = "·", nbsp = "·" }, -- Set listchars
    mouse = "a", -- Allow the mouse to be used in neovim
    mousemoveevent = true, -- Enable mouse events for bufferline reveal
    modeline = false, -- Disable modelines as security precaution
    number = true, -- Set numbered lines
    numberwidth = 2, -- Set number column width to 2 {default 4}
    pumblend = 0, -- Make popup windows blend
    pumheight = 10, -- Pop up menu height
    preserveindent = true, -- Preserve indent structure as much as possible
    relativenumber = false, -- Set relative numbered lines
    ruler = false, -- Show position
    scrolloff = 8, -- Set offset to start scrolling vertically
    sidescrolloff = 8, -- Set offset to scroll sideways
    signcolumn = "yes", -- Always show the sign column, otherwise it would shift the text each time
    spelllang = { "en_us" }, -- Set spellcheck language
    shiftwidth = 2, -- The number of spaces inserted for each indentation
    showmode = false, -- We don't need to see things like -- INSERT -- anymore
    showtabline = 2, -- Always show tabs
    smartcase = true, -- Smart case
    smartindent = true, -- Make indenting smarter again
    softtabstop = 2, -- Insert 2 spaces for a tab
    splitkeep = "screen", -- Reduce scroll during window split
    splitbelow = true, -- Force all horizontal splits to go below current window
    splitright = true, -- Force all vertical splits to go to the right of current window
    smoothscroll = true, -- Smooth scrolling
    swapfile = false, -- Don't use swapfiles
    tabstop = 2, -- Insert 2 spaces for a tab
    textwidth = 80, -- Set max width to 80 characters
    termguicolors = true, -- Set term gui colors (most terminals support this)
    timeoutlen = 500, -- Time to wait for a mapped sequence to complete (in milliseconds)
    ttyfast = true, -- Assume fast terminal connection
    undofile = true, -- Enable persistent undo
    undolevels = 10000, -- Number of undo levels
    updatetime = 200, -- Faster completion (4000ms default)
    virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode
    wildmode = { "longest:full", "full" }, -- Command-line completion mode
    winminwidth = 5, -- Minimum window width
    wrap = false, -- Display lines as one long line
    writebackup = false, -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    winblend = 0, -- Make floating windows blend
    winborder = "rounded", -- Set window border style
  },
}

function M.setup()
  M.setup_globals()
  M.setup_options()
end

function M.setup_globals()
  -- Replaces impatient.nvim: https://github.com/neovim/neovim/pull/22668
  vim.loader.enable()

  for k, v in pairs(M.globals) do
    vim.g[k] = v
  end
end

function M.setup_options()
  for k, v in pairs(M.options) do
    vim.opt[k] = v
  end

  local border_fillchars = {
    bold = "vert:┃,horiz:━,horizdown:┳,horizup:┻,verthoriz:╋,vertleft:┫,vertright:┣",
    dot = "vert:·,horiz:·,horizdown:·,horizup:·,verthoriz:·,vertleft:·,vertright:·",
    double = "vert:║,horiz:═,horizdown:╦,horizup:╩,verthoriz:╬,vertleft:╣,vertright:╠",
    single = "vert:│,horiz:─,horizdown:┬,horizup:┴,verthoriz:┼,vertleft:┤,vertright:├",
    solid = "vert: ,horiz: ,horizdown: ,horizup: ,verthoriz: ,vertleft: ,vertright: ",
  }

  -- Shortmess is a comma separated list of flags that change the way messages
  -- are displayed. These flags can be used to suppress unwanted messages.
  --
  -- Default is "ltToOCF"
  --
  -- l: use "999L, 888B" instead of "999 lines, 888 bytes"
  -- t: truncate file message at the start if it is too long
  --    to fit on the command-line, "<" will appear in the left most
  --    column; ignored in Ex mode
  -- T: truncate file message in the middle if it is too long to fit
  -- o: overwrite message for writing a file with subsequent message for reading
  -- O: message for reading a file overwrites any previous message
  -- C: don't give messages when scanning for ins-completion (cmp) items
  -- F: don't give the file info when editing a file, like :silent was used
  -- c: don't give ins-completion-menu messages
  -- W: don't give "written" or "[w]" when writing a file
  vim.opt.shortmess:append("WcC")
  vim.opt.whichwrap:append("<,>,[,],h,l")
  vim.opt.fillchars:append(border_fillchars.bold)
  vim.cmd("filetype plugin indent on") -- Enable all filetype plugins
end

_G._vim_opts = M

return M
