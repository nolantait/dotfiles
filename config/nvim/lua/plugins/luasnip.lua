-- Snippet provider for cmp

return function()
  local luasnip = require("luasnip")

  luasnip.setup({
    history = true,
    update_events = "TextChanged, TextChangedI",
    delete_check_events = "TextChanged, InsertLeave",
  })

  -- Add Rails snippets
  luasnip.filetype_extend("ruby", {"rails"})

  require("luasnip.loaders.from_lua").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load()
end
