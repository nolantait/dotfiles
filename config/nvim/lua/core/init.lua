-- DOCS: Load all the rest of the files in the core folder
-- This lets us just call require("core") to load everything in init.lua
-- lua will look for a file named init.lua by default if the path is a folder

require "core.vim"
require "core.prequire"
require "core.options"
require "core.keymaps"
require "core.autocommands"
