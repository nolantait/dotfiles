-- DOCS: Completions plugin for code suggestions

return function()
  local cmp = require("cmp")
  local utils = require("plugins.configs.cmp.utils")
  local core_utils = require("core.utils")
  local tainted = require("utils.cmp")

  -- Load our module for copilot_cmp which we use to wrap functions below
  -- conditionally on it being available. Doing this so we can easily remove
  -- without breaking.
  local copilot_cmp = require("plugins.configs.cmp.copilot-cmp")
  copilot_cmp.setup()

  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

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
  }

  -- Setup cmp with everything above
  cmp.setup({
    completion = {
      autocomplete = {
        cmp.TriggerEvent.TextChanged,
      },
      -- completeopt = "menu,menuone,noinsert,noselect",
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
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = tainted.confirm({ select = false }),
      ["<S-CR>"] = tainted.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
      ["<Tab>"] = cmp.mapping(commands.next_item, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(commands.previous_item, { "i", "s" }),
    },
    matching = {
      disallow_prefix_unmatching = true,
      disallow_fullfuzzy_matching = true,
      disallow_fuzzy_matching = true,
      disallow_partial_matching = false,
      disallow_partial_fuzzy_matching = true,
      disallow_symbol_nonprefix_matching = true,
    },
    preselect = cmp.PreselectMode.Item,
    -- performance = {
    --   debounce = 60,
    --   throttle = 30,
    --   fetching_timeout = 1000,
    --   confirm_resolve_timeout = 80,
    --   async_budget = 1,
    --   max_view_entries = 200
    -- },
    sources = cmp.config.sources({
      {
        name = "copilot",
        max_view_entries = 3,
      },
      { name = "nvim_lua" },
      {
        name = "nvim_lsp",
        keyword_length = 5,
        entry_filter = utils.limit_lsp_types,
      },
      { name = "path" },
    }, {
      { name = "buffer" },
    }),
    sorting = {
      priority_weight = 2,
      comparators = comparators,
    },
    window = {
      completion = {
        border = core_utils.border("FloatBorderCmp"),
      },
      documentation = {
        border = core_utils.border("FloatBorderCmp"),
      },
    },
    experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    },
    view = {
      entries = "custom", -- One of: "native" | "wildmenu" | "custom"
      docs = { auto_open = true },
    },
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "nvim_lsp_document_symbol" },
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
    matching = {
      disallow_symbol_nonprefix_matching = false,
    },
  })
end
