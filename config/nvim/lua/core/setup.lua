-- Replaces impatient.nvim: https://github.com/neovim/neovim/pull/22668
vim.loader.enable()
vim.api.nvim_set_var("loaded_perl_provider", 0)

-- Sets up keybinds
local keybinds = require("globals.keybinds")
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Unbind ?
keymap("", "?", "<Nop>", opts)

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Sets up keymaps according to keybinds file
for _, keybind in ipairs(keybinds) do
  keymap(keybind.mode, keybind.key, keybind.command, opts)
end

vim.cmd([[
  cnoreabbrev W w
]])
-- Done setting up keybinds


-- Disable menu loading
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu = 1

-- Uncomment this if you define your own filetypes in `after/ftplugin`
-- vim.g.did_load_filetypes = 1

-- Do not load native syntax completion
vim.g.loaded_syntax_completion = 1

-- Do not load spell files
vim.g.loaded_spellfile_plugin = 1

-- Whether to load netrw by default
vim.g.loaded_netrw = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
-- newtrw liststyle: https://medium.com/usevim/the-netrw-style-options-3ebe91d42456
-- vim.g.netrw_liststyle = 3

-- Do not load tohtml.vim
vim.g.loaded_2html_plugin = 1

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Do not use builtin matchit.vim and matchparen.vim since the use of vim-matchup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- Disable sql omni completion.
vim.g.loaded_sql_completion = 1

-- Disable EditorConfig support
vim.g.editorconfig = 1

-- Disable remote plugins
-- NOTE: Disabling rplugin.vim will show error for `wilder.nvim` in :checkhealth,
-- NOTE:  but since it's config doesn't require python rtp, it's fine to ignore.
vim.g.loaded_remote_plugins = 1 -- Disable menu loading

-- Disable markdown folding
vim.g.vim_markdown_folding_disabled = 1

-- Fenced languages syntax highlight in markdown
vim.g.vim_markdown_fenced_languages = {
  "c==cpp",
  "viml=vim",
  "bash=sh",
  "ini=dosini",
  "py=python",
}

-- Highlight YAML/TOML/JSON front matter.
vim.g.vim_markdown_frontmatter = true

-- Strikethrough uses two tildes.
vim.g.vim_markdown_strikethrough = true
