-- DOCS: This is the filesystem viewer that shows up on the left of the screen

local config = function()
  local neotree = require("neo-tree")
  local events = require("neo-tree.events")
  local icons = require("globals.icons")
  local utils = require("core.utils")

  local function on_move(data)
    require("snacks").rename.on_rename_file(data.source, data.destination)
  end

  -- Remove deprecated commands from v1.x
  vim.g.neo_tree_remove_legacy_commands = 1

  neotree.setup({
    close_if_last_window = true,
    commands = {
      avante_add_files = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local relative_path = require("avante.utils").relative_path(filepath)

        local sidebar = require("avante").get()

        local open = sidebar:is_open()
        -- ensure avante sidebar is open
        if not open then
          require("avante.api").ask()
          sidebar = require("avante").get()
        end

        sidebar.file_selector:add_selected_file(relative_path)

        -- remove neo tree buffer
        if not open then
          sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
        end
      end,
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if node:has_children() and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(
            state,
            node:get_parent_id()
          )
        end
      end,
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
              require("neo-tree.ui.renderer").focus_node(
                state,
                node:get_child_ids()[1]
              )
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
        event = events.NEO_TREE_BUFFER_ENTER,
        handler = function(_)
          vim.opt_local.signcolumn = "auto"
          vim.opt_local.foldcolumn = "0"
        end,
      },
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          h = "toggle_hidden",
        },
      },
    },
    open_files_do_not_replace_types = {
      "_neotest",
      "terminal",
      "Trouble",
      "qf",
      "Outline",
    },
    popup_border_style = "rounded",
    source_selector = {
      winbar = true,
      content_layout = "center",
      sources = {
        {
          source = "filesystem",
          display_name = " " .. icons.folders.default .. " Files ",
        },
        {
          source = "buffers",
          display_name = " " .. icons.pencil .. " Buffers ",
        },
        {
          source = "git_status",
          display_name = " " .. icons.git.branch .. " Git ",
        },
      },
      highlight_tab = "NeoTreeTab",
      highlight_tab_active = "NeoTreeTabActive",
      highlight_background = "NeoTreeBackground",
      highlight_separator = "NeoTreeSeparator",
      highlight_separator_active = "NeoTreeSeparatorActive",
      show_separator_on_edge = false,
      separator_active = false,
      tabs_layout = "focus",
    },
    update_in_insert = false,
    window = {
      width = 30,
      mappings = {
        ["oa"] = "avante_add_files",
        H = "prev_source",
        L = "next_source",
        l = "child_or_open",
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

return {
  {
    -- Filesystem tree on the left side of the screen
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim", -- improved UI components
    },
    config = config,
    keys = {
      {
        "<leader>e",
        mode = { "n", "v" },
        desc = "Toggle NeoTree",
        function()
          vim.cmd("Neotree toggle")
        end,
      },
    },
  },
}
