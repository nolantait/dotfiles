return {
  {
    "nickjvandyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      {
        "folke/snacks.nvim",
        opts = { input = {}, picker = {}, terminal = {} },
      },
    },
    keys = {
      {
        "<Leader>oc",
        mode = { "n", "t" },
        desc = "Toggle opencode",
        function()
          require("opencode").toggle()
        end,
      },
      {
        "<Leader>ox",
        mode = { "n", "x" },
        desc = "Execute opencode action",
        function()
          require("opencode").select()
        end,
      },
      {
        "<S-C-u>",
        mode = "n",
        desc = "Scroll opencode up",
        function()
          require("opencode").command("session.half.page.up")
        end,
      },
      {
        "<S-C-d>",
        mode = "n",
        desc = "Scroll opencode down",
        function()
          require("opencode").command("session.half.page.down")
        end,
      },
    },
    config = function()
      vim.g.opencode_opts = {}
    end,
  },
}
