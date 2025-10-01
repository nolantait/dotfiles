return {
  {
    "saghen/blink.cmp",
    event = "LazyFile",
    dependencies = {
      "fang2hou/blink-copilot",
    },
    version = "1.*",

    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        callback = function()
          vim.b.copilot_suggestion_hidden = true
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuClose",
        callback = function()
          vim.b.copilot_suggestion_hidden = false
        end,
      })
    end,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          "select_next",
          "snippet_forward",
          function()
            local buffer = vim.b[vim.api.nvim_get_current_buf()]
            if buffer.nes_state then
              local ok, nes = prequire("copilot-lsp.nes")
              if ok and nes then
                nes.apply_pending_nes()
                nes.walk_cursor_end_edit()
              end
            end
          end,
          -- @see sidekick
          function() -- sidekick next edit suggestion
            local ok, sidekick = prequire("sidekick")
            if ok and sidekick then
              sidekick.nes_jump_or_apply()
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      appearance = { nerd_font_variant = "mono" },
      signature = { enabled = true },
      fuzzy = { implementation = "rust" },
      completion = {
        keyword = { range = "full" },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = { enabled = true },
        list = {
          selection = {
            preselect = false,
          },
        },
        menu = {
          auto_show = true,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "kind" },
              { "source_name" },
            },
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          buffer = {
            score_offset = -1,
          },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
