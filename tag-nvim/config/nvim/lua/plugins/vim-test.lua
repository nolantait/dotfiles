return {
  {
    "vim-test/vim-test",
    init = function()
      local tmux = require("utils.vim-test.tmux")

      vim.g["test#custom_strategies"] = { tmux = tmux.execute }

      vim.g["test#strategy"] = "tmux"

      -- if tmux.in_tmate() then
      --   vim.g["test#strategy"] = "neovim_sticky"
      -- else
      --   vim.g["test#strategy"] = "tmux"
      -- end
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
        "<leader>a",
        mode = { "n", "v" },
        desc = "Test suite",
        function()
          vim.cmd("TestSuite")
        end,
      },
      {
        "<leader>A",
        mode = { "n", "v" },
        desc = "Test suite",
        function()
          vim.cmd("TestSuite --only-failures")
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
