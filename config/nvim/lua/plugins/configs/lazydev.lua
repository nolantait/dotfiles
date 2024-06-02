
return function()
  local cmp = require("cmp")
  local lazydev = require("lazydev")

  cmp.config.sources({
    name = "lazydev",
    group_index = 0, -- skip loading LuaLS completions
  })

  lazydev.setup({
    library = {
      "core",
      "luvit-meta/library"
    }
  })
end
