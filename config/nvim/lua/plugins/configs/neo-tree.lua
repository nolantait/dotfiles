-- DOCS: This is the filesystem viewer that shows up on the left of the screen

return function()
  local neotree = require("neo-tree")
  local icons = require("globals.icons")

  -- Remove deprecated commands from v1.x
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  neotree.setup({
    close_if_last_window = true,
    default_component_configs = {
      indent = {
        padding = 0,
        indent_size = 2,
      },
      icon = {
        folder_closed = icons.folders.closed,
        folder_open = icons.folders.open,
        folder_empty = icons.folders.empty,
        default = icons.folders.default,
      },
      git_status = {
        symbols = {
          added = icons.git.added,
          deleted = icons.git.removed,
          modified = icons.git.modified,
          renamed = icons.git.renamed,
          untracked = icons.git.untracked,
          ignored = icons.git.ignored,
          unstaged = icons.git.unstagged,
          staged = icons.git.staged,
          conflict = icons.git.conflict,
        },
      },
    },
    enable_git_status = true,
    enable_diagnostics = true,
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_)
          vim.opt_local.signcolumn = "auto"
        end
      },
      {
        event = 'neo_tree_buffer_leave',
        -- HACK: Workaround for https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1415
        handler = function()
          local shown_buffers = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            shown_buffers[vim.api.nvim_win_get_buf(win)] = true
          end
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if not shown_buffers[buf] and vim.api.nvim_buf_get_option(buf, 'buftype') == 'nofile' and vim.api.nvim_buf_get_option(buf, 'filetype') == 'neo-tree' then
              vim.api.nvim_buf_delete(buf, {})
            end
          end
        end,
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          h = "toggle_hidden"
        }
      },
    },
    open_files_do_not_replace_types = {
      "terminal",
      "Trouble",
      "qf",
      "Outline"
    },
    popup_border_style = "rounded",
    source_selector = {
      winbar = true,
      content_layout = "start",
      sources = {
        {
          source = "filesystem",
          display_name = " " .. icons.folders.default .. " Files "
        },
        {
          source = "buffers",
          display_name = " " .. icons.pencil .. " Buffers "
        },
        {
          source = "git_status",
          display_name = " " .. icons.git.branch .. " Git "
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
    window = {
      width = 30,
      mappings = {
        o = "open",
        H = "prev_source",
        L = "next_source",
      },
    },
  })

  -- Refresh git status whenever we close another window
  vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*lazygit",
    callback = function()
      if package.loaded["neo-tree.sources.git_status"] then
        require("neo-tree.sources.git_status").refresh()
      end
    end,
  })
end
