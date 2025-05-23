-- DOCS: Split and join arguments using gs

return {
  {
    "echasnovski/mini.splitjoin",
    event = "LazyFile",
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      -- Created for both Normal and Visual modes.
      mappings = {
        toggle = "gs",
        split = "",
        join = "",
      },

      -- Detection options: where split/join should be done
      detect = {
        -- Array of Lua patterns to detect region with arguments.
        -- Default: { "%b()", "%b[]", "%b{}" }
        brackets = nil,

        -- String Lua pattern defining argument separator
        separator = ",",

        -- Array of Lua patterns for sub-regions to exclude separators from.
        -- Enables correct detection in presence of nested brackets and quotes.
        -- Default: { "%b()", "%b[]", "%b{}", "%b""", "%b""" }
        exclude_regions = nil,
      },

      -- Split options
      split = {
        hooks_pre = {},
        hooks_post = {},
      },

      -- Join options
      join = {
        hooks_pre = {},
        hooks_post = {},
      },
    },
  },
}
