return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      global_settings = {
        mark_branch = false,
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        excluded_filetypes = { "harpoon" },
        tabline = true,
        tabline_prefix = " ",
        tabline_suffix = " ",
        tmux_autoclose_windows = true,
      },
    },
    keys = {
      {
        "<leader>ha",
        mode = { "n" },
        desc = "Harpoon add file",
        function()
          require("harpoon.mark").add_file()
        end,
      },
      {
        "<leader>hr",
        mode = { "n" },
        desc = "Harpoon remove file",
        function()
          require("harpoon.mark").rm_file()
        end,
      },
      {
        "<leader>hh",
        mode = { "n" },
        desc = "Harpoon toggle menu",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
      },
      {
        "<leader>hm",
        mode = { "n" },
        desc = "Telescope search Harpoon marks",
        function()
          vim.cmd("Telescope harpoon marks")
        end,
      },
      {
        "<leader>h1",
        mode = { "n" },
        desc = "Harpoon quick menu 1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
      },
      {
        "<leader>h2",
        mode = { "n" },
        desc = "Harpoon quick menu 2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
      },
      {
        "<leader>h3",
        mode = { "n" },
        desc = "Harpoon quick menu 3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
      },
      {
        "<leader>h4",
        mode = { "n" },
        desc = "Harpoon quick menu 4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
      },
    },
  },
}
