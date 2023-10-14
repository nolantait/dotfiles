-- DOCS: This sets some basic options for neovim such as tabs or spaces, etc

local options = {
  backup = false,                                  -- Prevents creating a backup file
  backspace = "2",                                 -- Backspace deletes like most programs in insert mode
  breakindent = true,                              -- Wrap indent to match line start
  clipboard = "unnamedplus",                       -- Allows neovim to access the system clipboard
  cmdheight = 0,                                   -- More space in the neovim command line for displaying messages
  completeopt = { "menu", "menuone", "noselect" }, -- Mostly just for cmp
  copyindent = true,                               -- Copy the previous indentation on autoindenting
  conceallevel = 0,                                -- So that `` is visible in markdown files
  cursorline = true,                               -- Highlight the current line
  expandtab = true,                                -- Convert tabs to spaces
  fileencoding = "utf-8",                          -- The encoding written to a file
  fillchars = { eob = " " },                       -- Disable "~" on nonexistent lines
  history = 100,                                   -- Number of commands to remember in a history table
  hlsearch = true,                                 -- Highlight all matches on previous search pattern
  ignorecase = true,                               -- Ignore case in search patterns
  infercase = true,                                -- Infer cases in keyword completion
  joinspaces = false,                              -- One space after punctuation
  laststatus = 0,                                  -- Global status
  linebreak = true,                                -- Wrap lines at 'breakat'
  mouse = "a",                                     -- Allow the mouse to be used in neovim
  modeline = false,                                -- Disable modelines as security precaution
  number = true,                                   -- Set numbered lines
  numberwidth = 2,                                 -- Set number column width to 2 {default 4}
  pumblend = 10,                                   -- Popup blend
  pumheight = 10,                                  -- Pop up menu height
  preserveindent = true,                           -- Preserve indent structure as much as possible
  relativenumber = false,                          -- Set relative numbered lines
  ruler = false,                                   -- Show position
  scrolloff = 8,                                   -- Set offset to start scrolling vertically
  sidescrolloff = 8,                               -- Set offset to scroll sideways
  signcolumn = "yes",                              -- Always show the sign column, otherwise it would shift the text each time
  spelllang = { "en" },                            -- Set spellcheck language
  shiftwidth = 2,                                  -- The number of spaces inserted for each indentation
  showmode = false,                                -- We don't need to see things like -- INSERT -- anymore
  showtabline = 2,                                 -- Always show tabs
  smartcase = true,                                -- Smart case
  smartindent = true,                              -- Make indenting smarter again
  softtabstop = 2,                                 -- Insert 2 spaces for a tab
  splitbelow = true,                               -- Force all horizontal splits to go below current window
  splitright = true,                               -- Force all vertical splits to go to the right of current window
  swapfile = false,                                -- Don't use swapfiles
  tabstop = 2,                                     -- Insert 2 spaces for a tab
  textwidth = 80,                                  -- Set max width to 80 characters
  termguicolors = true,                            -- Set term gui colors (most terminals support this)
  timeoutlen = 500,                                -- Time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                                 -- Enable persistent undo
  undolevels = 10000,                              -- Number of undo levels
  updatetime = 300,                                -- Faster completion (4000ms default)
  wildmode = { "longest:full", "full" },           -- Command-line completion mode
  wrap = false,                                    -- Display lines as one long line
  writebackup = false,                             -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set colorcolumn=+1]]
vim.cmd [[set list listchars=tab:»·,trail:·,nbsp:· "]]
