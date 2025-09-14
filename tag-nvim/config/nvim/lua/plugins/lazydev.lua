-- DOCS: Lua LSP setup for neovim

local config = function()
  local lazydev = require("lazydev")

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
    dependencies = { "Bilal2453/luvit-meta" },
    ft = { "lua" },
  },
}
