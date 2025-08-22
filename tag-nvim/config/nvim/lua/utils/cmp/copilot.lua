-- DOCS: Provides copilot as a source to cmp

local M = {
  loaded = false,
}

M.setup = function()
  local ok, copilot_cmp = pcall(require, "copilot_cmp")
  local cmp = require("cmp")

  M.loaded = ok

  cmp.event:on("menu_opened", function()
    vim.b.copilot_suggestion_hidden = true
  end)

  cmp.event:on("menu_closed", function()
    vim.b.copilot_suggestion_hidden = false
  end)

  if ok then
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    copilot_cmp.setup({
      -- method = "getCompletionsCycling",
      event = { "InsertEnter", "LspAttach" },
      fix_pairs = true,
      formatters = {
        label = require("copilot_cmp.format").format_label_text,
        insert_text = require("copilot_cmp.format").format_insert_text,
        preview = require("copilot_cmp.format").deindent,
      },
    })

    local utils = require("utils.cmp.utils")

    utils.actions.ai_accept = function()
      local suggestion = require("copilot.suggestion")
      if suggestion.is_visible() then
        utils.create_undo()
        suggestion.accept()
        return true
      end
    end
  end
end

M.apply = function(default)
  if M.loaded then
    local copilot = require("copilot_cmp.comparators")
    local comparators = {
      copilot.prioritize,
      copilot.score,
    }

    for _, v in pairs(comparators) do
      table.insert(default, 1, v)
    end
  end

  return default
end

return M
