-- DOCS: This file gets loaded by init.lua in the root folder and is the main
-- entrypoint for our plugins setup which uses lazy.nvim to load our plugins on
-- demand and in the background to improve the performance of our editor.

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

-- Sets up LazyFile event as a catchall for file events
local events = require("lazy.core.handler.event")
events.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }

-- Load settings and list of plugins
local options = require("plugins.options")
local plugins = require("plugins.list")

require("lazy").setup(plugins, options)
