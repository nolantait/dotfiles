-- DOCS: This is our main entrypoint for our setup. Neovim will load this file
-- first and this file is responsible for loading everything else

-- Load core config
require("core.init").setup()

-- Load plugins with lazy
require("load-plugins").setup()
