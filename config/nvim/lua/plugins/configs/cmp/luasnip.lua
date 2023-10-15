-- DOCS: Snippet provider for cmp

local M = {
  loaded = false,
}

M.setup = function()
  local ok, luasnip = pcall(require, "luasnip")
  M.loaded = ok

  if M.loaded then
    luasnip.setup({
      history = true,
      update_events = "TextChanged, TextChangedI",
      delete_check_events = "TextChanged, InsertLeave",
    })

    -- Add Rails snippets
    luasnip.filetype_extend("ruby", { "rails" })

    require("luasnip.loaders.from_lua").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load()
  end
end

M.expand_snippet = function(default)
  if M.loaded then
    local luasnip = require("luasnip")

    return function(args)
      luasnip.lsp_expand(args.body)
    end
  else
    return default
  end
end

M.next_item = function(default)
  if M.loaded then
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local utils = require("plugins.configs.cmp.utils")

    return function(fallback)
      if cmp.visible() then
        cmp.select_next_item({
          behavior = cmp.SelectBehavior.Select
        })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif utils.check_backspace() then
        fallback()
      else
        fallback()
      end
    end
  else
    return default
  end
end

M.previous_item = function(default)
  if M.loaded then
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    return function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({
          behavior = cmp.SelectBehavior.Select
        })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end
  else
    return default
  end
end

M.apply = function(functions)
  return {
    next_item = M.next_item(functions.next_item),
    previous_item = M.previous_item(functions.previous_item),
    expand_snippet = M.expand_snippet(functions.expand_snippet),
  }
end

return M
