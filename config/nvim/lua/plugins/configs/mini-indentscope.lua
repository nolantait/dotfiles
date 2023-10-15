return function()
  local mini_indentscope = require("mini.indentscope")

  mini_indentscope.setup({
    draw = {
      animation = mini_indentscope.gen_animation.quadratic({
        easing = "out",
        duration = 400,
        unit = "total"
      })
    },
    symbol = "|",
    options = {
      try_as_border = true,
    }
  })
end
