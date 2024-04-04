-- DOCS: Shows indent levels with a vertical line on the left of the buffer

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
        "prompt",
        "quickfix",
        "terminal"
      },
      filetypes = {
        "aerial",
        "alpha",
        "dashboard",
        "help",
        "lazy",
        "lspinfo",
        "mason",
        "neo-tree",
        "NvimTree",
        "neogitstatus",
        "notify",
        "packer",
        "startify",
        "toggleterm",
        "terminal",
        "NvimTree",
        "TelescopePrompt",
        "TelescopeResults",
        "Trouble",
      },
    },
    indent = { char = "|" }
  })
end
