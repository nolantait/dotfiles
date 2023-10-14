-- DOCS: This is our main entrypoint for our setup. Neovim will load this file
-- first and this file is responsible for loading everything else

-- Load core config
require "core"

-- Load plugins with lazy
require "plugins"

-- Personal plugins
require "custom.gem"
require "custom.profiling"
