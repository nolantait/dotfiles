-- Provides copilot as a source to cmp

return function()
  local copilot_cmp = require("copilot_cmp")

  if copilot_cmp then
      copilot_cmp.setup({
        method = "getCompletionsCycling"
      })
  end
end
