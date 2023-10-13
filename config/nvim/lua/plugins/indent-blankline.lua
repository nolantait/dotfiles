-- Shows indent levels with a vertical line on the left of the buffer

return function()
  local ibl = require("ibl")
  local hooks = require("ibl.hooks")

  hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
  )

  ibl.setup({
    exclude = {
      buftypes = {
        "nofile",
        "terminal",
      },
      filetypes = {
        "NvimTree",
        "TelescopePrompt",
        "TelescopeResults",
        "Trouble",
        "aerial",
        "alpha",
        "dashboard",
        "help",
        "lspinfo",
        "mason",
        "neo-tree",
        "neogitstatus",
        "packer",
        "startify",
        "terminal",
        ""
      },
    },
    indent = { char = "|" }
  })
end
