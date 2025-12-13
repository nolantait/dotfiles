-- DOCS: Better UI for neovim, used by other plugins

local icons = require("globals.icons")

return {
  {
    -- Better UI elements for neovim
    "stevearc/dressing.nvim",
    enabled = false,
    event = "VeryLazy",
    init = function()
      -- Init functions are always executed during startup.
      -- We can use this to override the default vim.ui functions
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
    end,
    opts = {
      input = {
        default_prompt = icons.play .. " ",
        win_options = {
          winhighlight = "Normal:Normal,NormalNC:Normal",
        },
      },
      select = {
        backend = { "telescope", "builtin" },
        builtin = {
          win_options = {
            winhighlight = "Normal:Normal,NormalNC:Normal",
          },
        },
      },
    },
  },
}
