-- DOCS: Sets up some vim global variables

-- Replaces impatient.nvim: https://github.com/neovim/neovim/pull/22668
vim.loader.enable()

local g = vim.g

-- Disable providers
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0
g.loaded_node_provider = 0

--Remap space as leader key
g.mapleader = " "
g.maplocalleader = " "

-- Disable menu loading
g.did_install_default_menus = 1
g.did_install_syntax_menu = 1

-- Uncomment this if you define your own filetypes in `after/ftplugin`
-- g.did_load_filetypes = 1

-- Do not load native syntax completion
g.loaded_syntax_completion = 1

-- Do not load spell files
g.loaded_spellfile_plugin = 1

-- Do not load netrw by default
g.loaded_netrw = 1
g.loaded_netrwFileHandlers = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
-- newtrw liststyle: https://medium.com/usevim/the-netrw-style-options-3ebe91d42456
-- g.netrw_liststyle = 3

-- Do not load tohtml.vim
g.loaded_2html_plugin = 1

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1

-- Disable sql omni completion.
g.loaded_sql_completion = 1

-- Disable EditorConfig support
g.editorconfig = 1

-- Disable remote plugins
-- NOTE: Disabling rplugin.vim will show error for `wilder.nvim` in :checkhealth,
--       but since it's config doesn't require python rtp, it's fine to ignore.
g.loaded_remote_plugins = 1 -- Disable menu loading

-- Disable markdown folding
g.vim_markdown_folding_disabled = 1

-- Fenced languages syntax highlight in markdown
g.vim_markdown_fenced_languages = {
  "c==cpp",
  "viml=vim",
  "bash=sh",
  "ini=dosini",
  "py=python",
  "rb=ruby",
  "ruby"
}

-- Highlight YAML/TOML/JSON front matter.
g.vim_markdown_frontmatter = true

-- Strikethrough uses two tildes.
g.vim_markdown_strikethrough = true
