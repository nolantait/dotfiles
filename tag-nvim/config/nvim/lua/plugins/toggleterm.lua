-- DOCS: Opens a terminal instance from within neovim with <C-\>

local utils = require("core.utils")

return {
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    keys = {
      {
        "<C-\\>",
        mode = { "n", "t" },
        desc = "Toggle Terminal",
        function()
          require("toggleterm").toggle()
        end,
      },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.40
        end
      end,
      on_open = function()
        -- Prevent infinite calls from freezing neovim.
        -- Only set these options specific to this terminal buffer.
        vim.api.nvim_set_option_value(
          "foldmethod",
          "manual",
          { scope = "local" }
        )
        vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
      end,
      highlights = {
        Normal = {
          link = "Normal",
        },
        NormalFloat = {
          link = "NormalFloat",
        },
        FloatBorder = {
          link = "FloatBorder",
        },
      },
      float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        border = utils.border("FloatBorder"),
        -- width = <value>,
        -- height = <value>,
        winblend = 0,
      },
      hide_numbers = true, -- Hide the number column in toggleterm buffers
      open_mapping = [[<C-\>]],
      shade_terminals = false,
      -- shading_factor = "1", -- The degree to darken the terminal color, 1 for dark, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- Whether to apply mappings to insert mode as well
      persist_size = true,
      direction = "float",
      close_on_exit = true, -- Close the terminal window when the process exits
      shell = vim.o.shell, -- Change to use our set shell (/usr/bin/zsh)
    },
  },
}
