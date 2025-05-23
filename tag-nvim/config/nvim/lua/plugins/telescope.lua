-- DOCS: Telescope provide fuzzy finding for many different aspects of your editor
-- This provides your <C-p> searching functionality

local config = function()
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
      -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      dynamic_preview_title = true,
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
      qflist_previewer = previewers.vim_buffer_qflist.new,
      buffer_previewer_maker = previewers.buffer_previewer_maker,
      file_sorter = sorters.get_fuzzy_file,
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
        width = 0.85,
        height = 0.92,
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
          "node_modules/*",
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
  telescope.load_extension("frecency")
  telescope.load_extension('harpoon')
end

return {
  {
    -- Fuzzy file searching
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = config,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      {
        "<C-p>",
        mode = { "n", "i" },
        desc = "Telescope find files",
        function()
          require("telescope.builtin").find_files()
        end,
      },
      {
        "\\",
        mode = "n",
        desc = "Telescope live grep",
        function()
          require("telescope.builtin").live_grep()
        end,
      },
      {
        "tm",
        mode = "n",
        desc = "Telescope man pages",
        function()
          require("telescope.builtin").man_pages()
        end,
      },
      {
        "thi",
        mode = "n",
        desc = "Telescope highlights",
        function()
          require("telescope.builtin").highlights()
        end,
      },
      {
        "the",
        mode = "n",
        desc = "Telescope help tags",
        function()
          require("telescope.builtin").help_tags()
        end,
      },
      {
        "tv",
        mode = "n",
        desc = "Telescope vim options",
        function()
          require("telescope.builtin").vim_options()
        end,
      },
      {
        "tk",
        mode = "n",
        desc = "Telescope keymaps",
        function()
          require("telescope.builtin").keymaps()
        end,
      },
      {
        "tc",
        mode = "n",
        desc = "Telescope commands",
        function()
          require("telescope.builtin").commands()
        end,
      },
      {
        "ta",
        mode = "n",
        desc = "Telescope autocommands",
        function()
          require("telescope.builtin").autocommands()
        end,
      },
      {
        "td",
        mode = "n",
        desc = "Telescope diagnostics",
        function()
          require("telescope.builtin").diagnostics()
        end,
      },
      {
        ";",
        mode = "n",
        desc = "Resume last telescope query",
        function()
          require("telescope.builtin").resume()
        end,
      },
    },
  },
}
