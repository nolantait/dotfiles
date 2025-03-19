-- DOCS: Gives hints on how to use Neovim better

return function()
  local hardtime = require("hardtime")

  hardtime.setup({
    restriction_mode = "hint",
    restricted_keys = {
      ["h"] = { },
      ["j"] = { },
      ["k"] = { },
      ["l"] = { },
      ["+"] = { "n", "x" },
      ["gj"] = { "n", "x" },
      ["gk"] = { "n", "x" },
      ["<C-M>"] = { "n", "x" },
      ["<C-N>"] = { "n", "x" },
      ["<C-P>"] = { },
    },
  })

  hardtime.enable()
end
