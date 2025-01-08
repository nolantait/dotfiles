-- DOCS: Animated highlighting of indents

return function()
  local mini_indentscope = require("mini.indentscope")

  mini_indentscope.setup({
    draw = {
      animation = mini_indentscope.gen_animation.quadratic({
        easing = "out",
        duration = 400,
        unit = "total",
      }),
    },
    symbol = "╎",
    options = {
      try_as_border = true,
    },
  })

  -- Create an autocommand to disable the plugin on certain filetypes
  vim.cmd([[
    augroup mini_indentscope
      autocmd!
      autocmd FileType alpha, lazy
      autocmd VimEnter * lua vim.b.miniindentscope_disable = true
    augroup END
  ]])
end
