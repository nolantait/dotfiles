-- DOCS: Completions plugin for code suggestions

return function()
  local cmp = require("cmp")
  local utils = require("plugins.configs.cmp.utils")
  local core_utils = require("core.utils")

  -- Load our module for luasnip and copilot_cmp which we use to wrap functions below
  -- conditionally on it being available. Doing this so we can easily remove
  -- without breaking.
  local luasnip = require("plugins.configs.cmp.luasnip")
  local copilot_cmp = require("plugins.configs.cmp.copilot-cmp")

  luasnip.setup()
  copilot_cmp.setup()

  local compare = cmp.config.compare
  local comparators = {
    compare.offset,
    compare.exact,
    utils.lsp_scores,
    compare.score,
    compare.recently_used,
    compare.locality,
    compare.kind,
    compare.sort_text,
    compare.length,
    compare.order,
  }

  -- Apply copilot_cmp conditionally on it being loaded
  comparators = copilot_cmp.apply(comparators)

  local commands = {
    next_item = function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end,
    previous_item = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end,
    expand_snippet = function(args)
      -- Do nothing
    end
  }

  -- Here we are wrapping the default behavior we specify here with additional luasnip
  -- functionality only if luasnip is loaded.
  --
  -- See the luasnip module for more information.
  --
  -- Doing this allows for other plugins to modify the behavior of our functions
  -- conditionally on them being loaded: a(b(c(default)))
  commands = luasnip.apply(commands)

  local float_style = {
    border = core_utils.border("FloatBorderCmp"),
    winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
  }

  -- Setup cmp with everything above
  cmp.setup {
    completion = {
      autocomplete = {
        cmp.TriggerEvent.TextChanged,
      },
      completeopt = 'menu,menuone,noselect',
      keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
      keyword_length = 1,
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = utils.format,
      expandable_indicator = true,
    },
    mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
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
      ["<Tab>"] = cmp.mapping(commands.next_item, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(commands.previous_item, { "i", "s" }),
    },
    matching = {
      disallow_prefix_unmatching = true,
      disallow_fullfuzzy_matching = true,
      disallow_fuzzy_matching = true,
      disallow_partial_matching = false,
      disallow_partial_fuzzy_matching = true
    },
    preselect = cmp.PreselectMode.Item,
    performance = {
      debounce = 60,
      throttle = 30,
      fetching_timeout = 1000,
      confirm_resolve_timeout = 80,
      async_budget = 1,
      max_view_entries = 200
    },
    sources = cmp.config.sources({
      {
        name = "copilot",
        max_view_entries = 3,
      },
      { name = "nvim_lua" },
      {
        name = "nvim_lsp",
        keyword_length = 5,
        entry_filter = utils.limit_lsp_types
      },
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
      expand = commands.expand_snippet
    },
    window = {
      completion = float_style,
      documentation = float_style,
    },
    experimental = {
      ghost_text = {
        hl_group = "Whitespace"
      },
    },
    view = {
      entries = "native"
    }
  }
end
