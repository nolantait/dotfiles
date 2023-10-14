local M = {}

local icons = require("globals.icons")

local kind_icons = {
  Text = icons.text,
  Method = icons.coding.method,
  Function = icons.coding.func,
  Constructor = icons.coding.constructor,
  Field = icons.coding.field,
  Variable = icons.coding.variable,
  Class = icons.coding.class,
  Interface = icons.coding.interface,
  Module = icons.coding.module,
  Property = icons.coding.property,
  Unit = icons.coding.unit,
  Value = icons.coding.value,
  Enum = icons.coding.enum,
  Keyword = icons.coding.keyword,
  Snippet = icons.coding.snippet,
  Color = icons.coding.color,
  File = icons.files.new,
  Reference = icons.coding.reference,
  Folder = icons.folders.default,
  EnumMember = icons.coding.enum,
  Constant = icons.coding.constant,
  Struct = icons.coding.struct,
  Event = icons.event,
  Operator = icons.coding.operator,
  TypeParameter = icons.coding.type,
  Copilot = icons.copilot
}

M.check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

M.border = function(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

M.format = function(entry, vim_item)
  vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

  vim_item.menu = ({
    copilot = "[Copilot]",
    nvim_lua = "[LUA]",
    nvim_lsp = "[LSP]",
    buffer = "[Buffer]",
    path = "[Path]",
    treesitter = "[TS]",
    spell = "[Spell]",
    luasnip = "[LuaSnip]",
  })[entry.source.name]

  return vim_item
end


M.lsp_scores = function(entry_a, entry_b)
  local score_a = entry_a.completion_item.score
  local score_b = entry_b.completion_item.score
  local diff = 0

  if score_a and score_b then
    diff = (score_b * entry_b.score) - (score_a * entry_a.score)
  else
    diff = entry_b.score - entry_a.score
  end

  return (diff < 0)
end


return M
