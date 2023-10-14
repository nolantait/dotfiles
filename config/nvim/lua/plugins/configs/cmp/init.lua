-- Completions plugin

return function()
  local cmp = require("cmp")
  local utils = require("plugins.configs.cmp.utils")

  -- Load our module for luasnip and copilot_cmp which we use to wrap functions below
  -- conditionally on it being available. Doing this so we can easily remove
  -- without breaking.
  local luasnip = require("plugins.configs.cmp.luasnip")
  local copilot_cmp = require("plugins.configs.cmp.copilot-cmp")

  luasnip.setup()
  copilot_cmp.setup()

  -- Here we apply our copilot comparators if and only if its loaded
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
  comparators = copilot_cmp.apply(comparators)

  -- Here we are wrapping the default behavior we specify here with additional luasnip
  -- functionality only if luasnip is loaded.
  --
  -- See the luasnip module for more information.
  --
  -- Doing this allows for other plugins to modify the behavior of our functions
  -- conditionally on them being loaded: a(b(c(default)))
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
        cmp.select_previous_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end,
    expand_snippet = function(args)
      -- Do nothing
    end
  }
  -- commands = luasnip.apply(commands)

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
      disallow_prefix_unmatching = false,
      disallow_fullfuzzy_matching = false,
      disallow_fuzzy_matching = false,
      disallow_partial_matching = true,
      disallow_partial_fuzzy_matching = false
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
      expand = commands.expand_snippet
    },
    window = {
      completion = {
        border = utils.border("PmenuBorder"),
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        scrollbar = true,
        scrolloff = 0,
        col_offset = 0,
        side_padding = 1
      },
      documentation = {
        border = utils.border("CmpDocBorder"),
        winhighlight = "FloatBorder:NormalFloat",
        scrollbar = true,
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