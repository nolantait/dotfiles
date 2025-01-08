-- DOCS: Utils used throughout cmp

local icons = require("globals.icons")

local M = {}

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
  Copilot = icons.copilot,
}

M.check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

M.format = function(entry, vim_item)
  -- Use tailwindcss-colorizer-cmp formatter if our kind is a tailwind color
  local ok, tw_colorizer = pcall(require, "tailwindcss-colorizer-cmp")
  if ok then
    local tw_item = tw_colorizer.formatter(entry, vim_item)
    if tw_item.kind == "XX" then
      return tw_item
    end
  end

  -- Otherwise use the default formatter
  vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

  vim_item.menu = ({
    copilot = "[Copilot]",
    nvim_lua = "[LUA]",
    nvim_lsp = "[LSP]",
    buffer = "[Buffer]",
    path = "[Path]",
    treesitter = "[TS]",
    spell = "[Spell]",
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

-- Limit the types of LSP options shown depending on what we are typing
-- For example, if we are typing a dot, only show methods, fields, and properties
M.limit_lsp_types = function(entry, ctx)
  local kind = entry:get_kind()
  local cursor = {
    line = ctx.cursor.line,
    column = ctx.cursor.col,
  }

  local char_before_cursor =
    string.sub(cursor.line, cursor.column - 1, cursor.column - 1)
  local char_after_dot = string.sub(cursor.line, cursor.column, cursor.column)
  local types = require("cmp.types").lsp.CompletionItemKind

  if char_before_cursor == "." and char_after_dot:match("[a-zA-Z]") then
    return kind == types.Method or kind == types.Field or kind == types.Property
  elseif string.match(cursor.line, "^%s+%w+$") then
    return kind == types.Function or kind == types.Variable
  elseif kind == require("cmp").lsp.CompletionItemKind.Text then
    return false
  end

  return true
end

return M
