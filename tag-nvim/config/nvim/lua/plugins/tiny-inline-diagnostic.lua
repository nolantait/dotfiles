return {
  {
    -- Improved syntax highlighting and code understanding for other plugins
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        multilines = {
          enabled = true,
          always_show = true,
          tabstop = 2
        },
        break_line = {
          -- Enable breaking messages after a specific length
          enabled = false,
          -- Number of characters after which to break the line
          after = 30,
        },
      })

      vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
    end,
  },
}
