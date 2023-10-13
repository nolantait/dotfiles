return function()
  local neotree = require("neo-tree")

  -- Remove deprecated commands from v1.x
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  neotree.setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    source_selector = {
      winbar = true,
      content_layout = "start",
      sources = {
        {
          source = "filesystem",
          display_name = "  Files "
        },
        {
          source = "buffers",
          display_name = "  Buffers "
        },
        {
          source = "git_status",
          display_name = "  Git "
        },
      },
      highlight_tab = "TabLine",
      highlight_tab_active = "NeoTreeTabActive",
      highlight_background = "TabLine",
      highlight_separator = "TabLineFill",
      highlight_separator_active = "IncSearch",
      show_separator_on_edge = false,
      separator_active = false,
      tabs_layout = "focus"
    },
    default_component_configs = {
      indent = {
        padding = 0,
        indent_size = 2,
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "",
      },
      git_status = {
        symbols = {
          added = "",
          deleted = "",
          modified = "",
          renamed = "➜",
          untracked = "★",
          ignored = "◌",
          unstaged = "✗",
          staged = "✓",
          conflict = "",
        },
      },
    },
    window = {
      width = 30,
      mappings = {
        ["<space>"] = false,   -- disable space until we figure out which-key disabling
        o = "open",
        H = "prev_source",
        L = "next_source",
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
      window = { mappings = { h = "toggle_hidden" } },
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_)
          vim.opt_local.signcolumn = "auto"
        end
      },
    },
  })
end
