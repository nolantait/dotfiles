-- DOCS: Lua LSP setup for neovim

local config = function()
  local cmp = require("cmp")
  local lazydev = require("lazydev")

  cmp.config.sources({
    name = "lazydev",
    group_index = 0, -- skip loading LuaLS completions
  })

  lazydev.setup({
    dependencies = {
      -- Manage libuv types with lazy. Plugin will never be loaded
      { "Bilal2453/luvit-meta", lazy = true },
    },
    library = {
      "core",
      { path = "luvit-meta/library", words = { "vim%.uv" } },
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
