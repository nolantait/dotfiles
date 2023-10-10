local status_ok, config = prequire("ibl")
if not status_ok then
  return
end

local hooks = require("ibl.hooks")

hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_space_indent_level
)

config.setup({
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
