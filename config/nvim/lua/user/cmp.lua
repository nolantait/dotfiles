local ok, cmp = prequire("cmp")
if not ok then
  return
end

if cmp then
  local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end

  local function border(hl_name)
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

  --   פּ ﯟ   some other good icons
  local kind_icons = {
    Text = "",
    Method = "m",
    Function = "󰊕",
    Constructor = "",
    Field = "",
    Variable = "󰫧",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "󰛦",
    Copilot = ""
  }
  -- find more here: https://www.nerdfonts.com/cheat-sheet

  local comparators = {
    cmp.config.compare.exact,
    cmp.config.compare.offset,
    cmp.config.compare.score,
    cmp.config.compare.recently_used,
    cmp.config.compare.locality,
    cmp.config.compare.kind,
    cmp.config.compare.sort_text,
    cmp.config.compare.length,
    cmp.config.compare.order,
  }

  -- Setup copilot cmp integration
  local copilot_ok, copilot_cmp = prequire("copilot_cmp")
  if copilot_ok and copilot_cmp then
    copilot_cmp.setup()
    local copilot_comparators = { require("copilot_cmp.comparators").prioritize }
    table.insert(comparators, 1, copilot_comparators[1])
  end

  local on_tab = function(fallback)
    fallback()
  end

  local on_shift_tab = function(fallback)
    fallback()
  end

  local expand_snippet = function(args)
    return
  end

  -- Optionally load luasnip support
  local luasnip_ok, luasnip = prequire("luasnip")
  if luasnip then
    on_tab = function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end

    on_shift_tab = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end

    expand_snippet = function(args)
      if not luasnip_ok then
        return
      end
      luasnip.lsp_expand(args.body)
    end
  end

  cmp.setup {
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
      ["<Tab>"] = cmp.mapping(on_tab, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(on_shift_tab, { "i", "s" }),
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        vim_item.menu = ({
          copilot = "[Copilot]",
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          path = "[Path]",
          luasnip = "[LuaSnip]",
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = cmp.config.sources({
      { name = "copilot" },
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
      { name = "luasnip" }
    }, {
      { name = "buffer" },
    }),
    sorting = {
      priority_weight = 2,
      comparators = comparators,
    },
    snippet = {
      expand = expand_snippet
    },
    window = {
      completion = {
        side_padding = 1,
        winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
        scrollbar = false
      },
      documentation = {
        border = border "CmpDocBorder",
        winhighlight = "Normal:CmpDoc",
      },
    },
    experimental = {
      ghost_text = false,
      native_menu = false,
    },
  }
end
