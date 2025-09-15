return {
  {
    "vim-test/vim-test",
    init = function()
      vim.g["test#strategy"] = "neovim_sticky"
      vim.keymap.set("t", "<C-o>", [[<C-\><C-n>]], { noremap = true, silent = true })
    end,
    keys = {
      {
        "<leader>t",
        mode = { "n", "v" },
        desc = "[t]est file",
        function()
          vim.cmd("TestFile")
        end,
      },
      {
        "<leader>s",
        mode = { "n", "v" },
        desc = "Test [s]ingle",
        function()
          vim.cmd("TestNearest")
        end,
      },
      {
        "<A-t>",
        mode = { "n", "v" },
        desc = "[o]utput",
        function()
          vim.cmd("TestOutput")
        end,
      },
    },
  },
}
