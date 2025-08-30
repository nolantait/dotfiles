return {
  "WilliamHsieh/overlook.nvim",
  opts = {
    ui = {
      border = "rounded", -- Border style: "none", "single", "double", "rounded", etc.
      z_index_base = 30, -- Base z-index for first popup
      row_offset = 2, -- Initial row offset from cursor
      col_offset = 5, -- Initial column offset from cursor
      stack_row_offset = 1, -- Vertical offset for stacked popups
      stack_col_offset = 2, -- Horizontal offset for stacked popups
      width_decrement = 2, -- Width reduction for each stacked popup
      height_decrement = 1, -- Height reduction for each stacked popup
      min_width = 10, -- Minimum popup width
      min_height = 3, -- Minimum popup height
      size_ratio = 0.65, -- Default size ratio (0.0 to 1.0)
      keys = {
        close = "q", -- Key to close the topmost popup
      },
    },
  },
  keys = {
    {
      "gp",
      function()
        require("overlook.api").peek_definition()
      end,
      desc = "Overlook: Peek definition",
    },
    {
      "<leader>pq",
      function()
        require("overlook.api").close_all()
      end,
      desc = "Overlook: Close all popup",
    },
    {
      "<leader>pc",
      function()
        require("overlook.api").peek_cursor()
      end,
      desc = "Overlook: Peek cursor",
    },
    {
      "<leader>pu",
      function()
        require("overlook.api").restore_popup()
      end,
      desc = "Overlook: Restore popup",
    },
    {
      "<leader>pU",
      function()
        require("overlook.api").restore_all_popups()
      end,
      desc = "Overlook: Restore all popups",
    },
  },
}
