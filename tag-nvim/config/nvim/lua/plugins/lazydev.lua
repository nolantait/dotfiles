-- DOCS: Lua LSP setup for neovim

local config = function()
  local cmp = require("cmp")
  local lazydev = require("lazydev")

  cmp.config.sources({
    name = "lazydev",
    group_index = 0, -- skip loading LuaLS completions
  })

  lazydev.setup({
    library = {
      "core",
      "luvit-meta/library",
    },
  })
end

return {
  {
    "folke/lazydev.nvim",
    config = config,
    dependencies = {
      "Bilal2453/luvit-meta",
      "hrsh7th/nvim-cmp",
    },
    ft = { "lua" },
  },
}
