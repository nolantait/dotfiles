-- DOCS: Telescope provide fuzzy finding for many different aspects of your editor
-- This provides your <C-p> searching functionality

return function()
  local telescope = require("telescope")
  local icons = require("globals.icons")
  local trouble = require("trouble.sources.telescope")

  local actions = require("telescope.actions")
  local previewers = require("telescope.previewers")
  local themes = require("telescope.themes")
  local sorters = require("telescope.sorters")

  telescope.setup({
    defaults = {
      border = false,
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      buffer_previewer_maker = previewers.buffer_previewer_maker,
      color_devicons = true,
      dynamic_preview_title = true,
      file_sorter = sorters.get_fuzzy_file,
      file_ignore_patterns = {
        "node_modules/",
        ".git/",
        ".cache",
        "build/",
        "%.class",
        "%.pdf",
        "%.mkv",
        "%.mp4",
        "%.zip",
      },
      generic_sorter = sorters.get_generic_fuzzy_sorter,
      file_previewer = previewers.vim_buffer_cat.new,
      grep_previewer = previewers.vim_buffer_vimgrep.new,
      initial_mode = "insert",
      layout_strategy = "flex",
      path_display = { "truncate" },
      prompt_prefix = icons.telescope .. " ",
      results_title = false,
      scroll_strategy = "cycle",
      selection_caret = icons.selected .. " ",
      selection_strategy = "reset", -- How the cursor acts after each sort
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      mappings = {
        i = {
          ["<C-t"] = trouble.open,
          ["<C-f>"] = actions.cycle_history_next,
          ["<C-b>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection
            + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-Tab>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        },
        n = {
          ["<C-t"] = trouble.open,
          ["<esc>"] = actions.close,
          ["q"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection
            + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
        },
      },
      qflist_previewer = previewers.vim_buffer_qflist.new,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      winblend = 0,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      lsp_references = { theme = "dropdown" },
      lsp_code_actions = { theme = "dropdown" },
      lsp_definitions = { theme = "dropdown" },
      lsp_implementations = { theme = "dropdown" },
      lsp_document_symbols = { theme = "dropdown" },
      buffers = {
        ignore_current_buffer = true,
        sort_mru = true,
        previewer = false,
      },
    },
    extensions = {
      frecency = {
        show_scores = true,
        show_unindexed = false,
        disable_devicons = false,
        ignore_patterns = {
          "*.git/*",
          "*/tmp/*",
          "term://*",
        },
        db_safe_mode = false,
        auto_validate = true,
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      ["ui-select"] = {
        themes.get_dropdown({}),
      },
    },
  })

  telescope.load_extension("ui-select")
  telescope.load_extension("fzf")
end
