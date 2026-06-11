return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      mark_branch = false,
      save_on_toggle = false,
      save_on_change = true,
      enter_on_sendcmd = false,
      excluded_filetypes = { "harpoon" },
      tmux_autoclose_windows = true,
    },
    keys = {
      {
        "<leader>ha",
        mode = { "n" },
        desc = "Harpoon add file",
        function()
          require("harpoon"):list():append()
        end,
      },
      {
        "<leader>hr",
        mode = { "n" },
        desc = "Harpoon remove file",
        function()
          require("harpoon"):list():remove()
        end,
      },
      {
        "<leader>hh",
        mode = { "n" },
        desc = "Harpoon toggle menu",
        function()
          require("harpoon"):list():open_ui()
        end,
      },
      {
        "<leader>hm",
        mode = { "n" },
        desc = "Telescope search Harpoon marks",
        function()
          require("harpoon"):list():open_ui({
            win = { enter = true },
            ui = { select_on_buf = false },
          })
        end,
      },
      {
        "<leader>h1",
        mode = { "n" },
        desc = "Harpoon quick menu 1",
        function()
          require("harpoon"):list():select(1)
        end,
      },
      {
        "<leader>h2",
        mode = { "n" },
        desc = "Harpoon quick menu 2",
        function()
          require("harpoon"):list():select(2)
        end,
      },
      {
        "<leader>h3",
        mode = { "n" },
        desc = "Harpoon quick menu 3",
        function()
          require("harpoon"):list():select(3)
        end,
      },
      {
        "<leader>h4",
        mode = { "n" },
        desc = "Harpoon quick menu 4",
        function()
          require("harpoon"):list():select(4)
        end,
      },
    },
  },
}
