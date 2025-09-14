-- DOCS: Replaces UI of `messages`, `cmdline` and `popupmenu`

return {
  {
    -- Completions for vim commands and paths
    "folke/noice.nvim",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    event = "CmdlineEnter",
    init = function()
      if vim.opt.filetype:get() == "lazy" then
        vim.cmd([[messages clear]])
      end
    end,
    opts = {
      cmdline = {
        enabled = true,
        format = {
          conceal = false,
        },
      },
      routes = {
        {
          filter = { event = "msg_showmode" },
          opts = { skip = true },
          view = "notify",
        },
        -- always route any messages with more than 20 lines to the split view
        {
          view = "split",
          filter = { event = "msg_show", min_height = 20 },
        },
      },
      message = {
        view = "snacks",
      },
      lsp = {
        progress = {
          enabled = false, -- using fidget.nvim
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      format = {
        cmdline = { pattern = "^:", icon = "", lang = "vim" },
        search_down = {
          kind = "search",
          pattern = "^/",
          icon = " ",
          lang = "regex",
        },
        search_up = {
          kind = "search",
          pattern = "^%?",
          icon = " ",
          lang = "regex",
        },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = {
          pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
          icon = "",
          lang = "lua",
        },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
        input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
      },
    },
  },
}
