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
  fillchars = "eob: ",
  formatoptions = "qjl1",                          -- Don't auto format comments
  history = 100,                                   -- Number of commands to remember in a history table
  hlsearch = true,                                 -- Highlight all matches on previous search pattern
  ignorecase = true,                               -- Ignore case in search patterns
  incsearch = true,                                -- Show search matches as you type
  infercase = true,                                -- Infer cases in keyword completion
  joinspaces = false,                              -- One space after punctuation
  laststatus = 0,                                  -- Global status
  linebreak = true,                                -- Wrap lines at 'breakat'
  mouse = "a",                                     -- Allow the mouse to be used in neovim
  mousemoveevent = true,                           -- Enable mouse events for bufferline reveal
  modeline = false,                                -- Disable modelines as security precaution
  number = true,                                   -- Set numbered lines
  numberwidth = 2,                                 -- Set number column width to 2 {default 4}
  pumblend = 10,                                   -- Make popup windows blend
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
  splitkeep = "screen",                                -- Reduce scroll during window split
  splitbelow = true,                               -- Force all horizontal splits to go below current window
  splitright = true,                               -- Force all vertical splits to go to the right of current window
  swapfile = false,                                -- Don't use swapfiles
  tabstop = 2,                                     -- Insert 2 spaces for a tab
  textwidth = 80,                                  -- Set max width to 80 characters
  termguicolors = true,                            -- Set term gui colors (most terminals support this)
  timeoutlen = 500,                                -- Time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                                 -- Enable persistent undo
  undolevels = 10000,                              -- Number of undo levels
  updatetime = 100,                                -- Faster completion (4000ms default)
  virtualedit = "block",                           -- Allow cursor to move where there is no text in visual block mode
  wildmode = { "longest:full", "full" },           -- Command-line completion mode
  wrap = false,                                    -- Display lines as one long line
  writebackup = false,                             -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  winblend = 10,                                   -- Make floating windows blend
}

local border_fillchars = {
  bold   = 'vert:┃,horiz:━,horizdown:┳,horizup:┻,verthoriz:╋,vertleft:┫,vertright:┣',
  dot    = 'vert:·,horiz:·,horizdown:·,horizup:·,verthoriz:·,vertleft:·,vertright:·',
  double = 'vert:║,horiz:═,horizdown:╦,horizup:╩,verthoriz:╬,vertleft:╣,vertright:╠',
  single = 'vert:│,horiz:─,horizdown:┬,horizup:┴,verthoriz:┼,vertleft:┤,vertright:├',
  solid  = 'vert: ,horiz: ,horizdown: ,horizup: ,verthoriz: ,vertleft: ,vertright: ',
}

vim.opt.fillchars:append(border_fillchars.bold)

-- NOTE: Default is "ltToOCF"
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
vim.opt.shortmess:append "WcC"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd("filetype plugin indent on") -- Enable all filetype plugins
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd [[set iskeyword+=-]] -- treat dash separated words as a word text object"
vim.cmd [[set colorcolumn=+1]] -- Highlight the 80th column
vim.cmd [[set list listchars=tab:»·,trail:·,nbsp:· "]] -- Show some invisible characters
