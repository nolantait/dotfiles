-- Load core plugins
require "user.options"
require "user.core"
require "user.utils"
require "user.plugins"
require "user.lsp"
require "user.colorscheme"

-- Load user plugins
require "user.alpha"
require "user.autocommands"
require "user.barbecue"
require "user.bufferline"
require "user.colorizer"
require "user.copilot"
require "user.devicons"
require "user.dressing"
require "user.gitsigns"
require "user.illuminate"
require "user.indent_blankline"
require "user.keymaps"
require "user.lualine"
require "user.matchup"
require "user.neo-tree"
require "user.profiling"
require "user.rails"
require "user.ruby"
require "user.snippets"
require "user.telescope"
require "user.treesitter"
require "user.treesitter-context"
require "user.whichkey"
require "user.wilder"

-- Ordering dependent
require "user.cmp"

-- Personal plugins
require "plugins.gem"
