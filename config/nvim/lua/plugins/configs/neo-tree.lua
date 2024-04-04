-- DOCS: This is the filesystem viewer that shows up on the left of the screen

return function()
  local neotree = require("neo-tree")
  local icons = require("globals.icons")

  -- Remove deprecated commands from v1.x
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  neotree.setup({
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    commands = {
      -- https://github.com/AstroNvim/AstroNvim/blob/9054fa4c767f0327340d82411d4e7f10307d9aca/lua/astronvim/plugins/neo-tree.lua#L116C1-L131C13
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node:has_children() then
          if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
          else -- if expanded and has children, seleect the next child
            if node.type == "file" then
              state.commands.open(state)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        else -- if has no children
          state.commands.open(state)
        end
      end,
    },
    default_component_configs = {
      indent = {
        padding = 0,
        expander_collapsed = icons.folders.closed,
        expander_expanded = icons.folders.open,
      },
      icon = {
        folder_closed = icons.folders.closed,
        folder_open = icons.folders.open,
        folder_empty = icons.folders.empty,
        folder_empty_open = icons.folders.empty,
        default = icons.folders.default,
      },
      modified = { symbol = icons.pencil },
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
          vim.opt_local.foldcolumn = "0"
        end
      },
      {
        event = 'neo_tree_buffer_leave',
        -- HACK: Workaround for https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1415
        --       Waiting for https://github.com/nvim-neo-tree/neo-tree.nvim/pull/1418 to be merged
        handler = function()
          local shown_buffers = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            shown_buffers[vim.api.nvim_win_get_buf(win)] = true
          end
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local is_nofile = vim.api.nvim_get_option_value('buftype', {buf=buf}) == 'nofile'
            local is_neotree = vim.api.nvim_get_option_value('filetype', {buf=buf}) == 'neo-tree'
            if not shown_buffers[buf] and is_nofile and is_neotree then
              vim.api.nvim_buf_delete(buf, {})
            end
          end
        end,
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false
      },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = vim.fn.has "win32" ~= 1,
      window = {
        mappings = {
          h = "toggle_hidden"
        }
      },
    },
    open_files_do_not_replace_types = {
      "_neotest",
      "terminal",
      "Trouble",
      "qf",
      "Outline"
    },
    popup_border_style = "rounded",
    source_selector = {
      winbar = true,
      content_layout = "center",
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
        l = "child_or_open"
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
