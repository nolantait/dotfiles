local ok, ibl = prequire("ibl")
if not ok then
  return
end

if ibl then
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
