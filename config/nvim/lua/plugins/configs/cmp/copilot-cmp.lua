-- DOCS: Provides copilot as a source to cmp

local M = {
  loaded = false
}

M.setup = function()
  local ok, copilot_cmp = pcall(require, "copilot_cmp")

  M.loaded = ok

  if ok then
    copilot_cmp.setup({
      method = "getCompletionsCycling",
      event = { "InsertEnter", "LspAttach" },
      fix_pairs = false
    })
  end
end

M.apply = function(default)
  if M.loaded then
    local copilot = require("copilot_cmp.comparators")
    local comparators = {
      copilot.prioritize,
      copilot.score
    }

    for _, v in pairs(comparators) do
      table.insert(default, 1, v)
    end
  end

  return default
end

return M
