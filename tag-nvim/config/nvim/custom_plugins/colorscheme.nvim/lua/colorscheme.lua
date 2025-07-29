local colors = require("globals.colors")

local M = {
  theme = {},
}

function M.setup()
  colors.foreground = colors.lightest_gray
  colors.background = "#1f2228"

  -- Loop through highlight files and load their configurations
  local highlights = {}
  for _, highlight in ipairs({ "editor", "lsp", "plugins" }) do
    local mod = require("highlights." .. highlight)
    for group, spec in pairs(mod.setup(colors)) do
      highlights[group] = spec
    end
  end

  -- Apply the highlights
  for group, spec in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, spec)
  end

  M.theme = highlights
end

return M
