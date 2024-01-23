-- DOCS: Animate cursor when jumping a large distance to keep eye focus

return function()
  local specs = require("specs")

  specs.setup({
    show_jumps = true,
    min_jump = 5,
    popup = {
      delay_ms = 0,   -- delay before popup displays
      inc_ms = 10,    -- time increments used for fade/resize effects
      blend = 10,     -- starting blend, between 0-100 (fully transparent), see :h winblend
      width = 10,
      winhl = "PmenuSbar",
      fader = specs.pulse_fader,
      resizer = specs.shrink_resizer,
    },
    ignore_filetypes = {},
    ignore_buftypes = { nofile = true },
  })
end
