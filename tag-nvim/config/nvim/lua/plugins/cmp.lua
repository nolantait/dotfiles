-- DOCS: Completions plugin for code suggestions

local config = function()
  local cmp = require("cmp")
  local utils = require("utils.cmp.utils")
  local core_utils = require("core.utils")

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
    enabled = function()
      local disabled = false

      disabled = disabled
        or (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt")
      disabled = disabled or (vim.fn.reg_recording() ~= "")
      disabled = disabled or (vim.fn.reg_executing() ~= "")

      return not disabled
    end,
    completion = {
      autocomplete = {
        cmp.TriggerEvent.TextChanged,
      },
      completeopt = "menu,menuone,noselect",
      keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
      keyword_length = 0,
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
      ["<CR>"] = utils.confirm({ select = false }),
      ["<S-CR>"] = utils.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
      ["<Tab>"] = cmp.mapping(commands.next_item, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(commands.previous_item, { "i", "s" }),
    },
    matching = {
      disallow_fullfuzzy_matching = false,
      disallow_fuzzy_matching = false,
      disallow_partial_fuzzy_matching = true,
      disallow_partial_matching = false,
      disallow_prefix_unmatching = false,
      disallow_symbol_nonprefix_matching = true,
    },
    preselect = cmp.PreselectMode.Item,
    performance = {
      debounce = 60,
      throttle = 30,
      fetching_timeout = 500,
      filtering_context_budget = 3,
      confirm_resolve_timeout = 80,
      async_budget = 1,
      max_view_entries = 200,
    },
    sources = cmp.config.sources({
      {
        name = "copilot",
        max_view_entries = 3,
        priority = 100,
        group_index = 1,
      },
      {
        name = "nvim_lsp",
        keyword_length = 5,
        entry_filter = utils.limit_lsp_types,
        group_index = 2,
      },
      {
        name = "path",
        group_index = 1,
      },
      {
        name = "crates",
        group_index = 1,
      },
      {
        name = "buffer",
        group_index = 1,
      },
    }),
    sorting = {
      priority_weight = 2,
      comparators = utils.setup_comparators(cmp),
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

return {
  {
    -- Tab completions with suggestions from many sources (copilot, lsp, etc)
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "andersevenrud/cmp-tmux",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "zbirenbaum/copilot-cmp",
    },
    config = config,
  },
}
