-- Completions plugin

return function()
  local cmp = require("cmp")

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

  local compare = cmp.config.compare

  compare.lsp_scores = function(entry_a, entry_b)
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

  local comparators = {
    compare.offset,
    compare.exact,
    compare.lsp_scores,
    compare.score,
    compare.recently_used,
    compare.locality,
    compare.kind,
    compare.sort_text,
    compare.length,
    compare.order,
  }

  -- Setup copilot cmp integration
  local copilot_ok, copilot_cmp = prequire("copilot_cmp")
  if copilot_ok and copilot_cmp then
    local copilot_comparators = {
      require("copilot_cmp.comparators").prioritize,
      require("copilot_cmp.comparators").score
    }
    -- Insert copilot suggestions into the top priority
    table.insert(comparators, 1, copilot_comparators[1])
  end

  -- Default implementation of on_tab
  local on_tab = function(fallback)
    if cmp.visible() then
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    else
      fallback()
    end
  end

  -- Default implementation of on_shift_tab
  local on_shift_tab = function(fallback)
    fallback()
  end

  -- Default implementation of expand_snippet
  local expand_snippet = function(args)
  end

  -- Optionally load luasnip support
  local luasnip_ok, luasnip = prequire("luasnip")
  if luasnip then
    -- Redefine on_tab to support luasnip
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

    -- Redefine on_shift_tab to support luasnip
    on_shift_tab = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end

    -- Redefine expand_snippet to support luasnip
    expand_snippet = function(args)
      if not luasnip_ok then
        return
      end
      luasnip.lsp_expand(args.body)
    end
  end

  -- Setup cmp with everything above
  cmp.setup {
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
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
      end,
    },
    mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable,   -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
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
    matching = {
      disallow_partial_fuzzy_matching = false
    },
    preselect = cmp.PreselectMode.Item,
    sources = cmp.config.sources({
      { name = "copilot" },
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
      { name = "luasnip" },
      { name = "spell" },
      { name = "treesitter" }
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
        border = border("PmenuBorder"),
        side_padding = 1,
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:PmenuSel",
        scrollbar = false
      },
      documentation = {
        border = border("CmpDocBorder"),
        winhighlight = "Normal:CmpDoc",
      },
    },
    experimental = {
      ghost_text = {
        hl_group = "Whitespace"
      },
      native_menu = false,
    },
  }
end
