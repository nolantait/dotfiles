-- DOCS: Utils used throughout cmp

local icons = require("globals.icons")

local M = {}

local KIND_ICONS = {
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

M.setup_comparators = function(cmp)
  local compare = cmp.config.compare
  local comparators = {
    compare.offset,
    compare.exact,
    compare.score,
    compare.recently_used,
    compare.locality,
    compare.kind,
    compare.sort_text,
    compare.length,
    compare.order,
  }
  local copilot_cmp = require("utils.cmp.copilot")
  copilot_cmp.setup()
  return copilot_cmp.apply(comparators)
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
  vim_item.kind = string.format("%s", KIND_ICONS[vim_item.kind])

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

M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
function M.create_undo()
  if vim.api.nvim_get_mode().mode == "i" then
    vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
  end
end

M.actions = {}

-- This is a better implementation of `cmp.confirm`:
--  * check if the completion menu is visible without waiting for running sources
--  * create an undo point before confirming
-- This function is both faster and more reliable.
---@param opts? {select: boolean, behavior: cmp.ConfirmBehavior}
function M.confirm(opts)
  local cmp = require("cmp")

  opts = vim.tbl_extend(
    "force",
    { select = true, behavior = cmp.ConfirmBehavior.Insert },
    opts or {}
  )

  return function(fallback)
    if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
      M.create_undo()
      if cmp.confirm(opts) then
        return
      end
    end
    return fallback()
  end
end

---@param entry cmp.Entry
function M.auto_brackets(entry)
  local cmp = require("cmp")
  local Kind = cmp.lsp.CompletionItemKind
  local item = entry.completion_item()

  if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
    local cursor = vim.api.nvim_win_get_cursor(0)
    local prev_char = vim.api.nvim_buf_get_text(
      0,
      cursor[1] - 1,
      cursor[2],
      cursor[1] - 1,
      cursor[2] + 1,
      {}
    )[1]
    if prev_char ~= "(" and prev_char ~= ")" then
      local keys =
        vim.api.nvim_replace_termcodes("()<left>", false, false, true)
      vim.api.nvim_feedkeys(keys, "i", true)
    end
  end
end

return M
