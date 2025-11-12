-- DOCS: AI coding assistant for Neovim with open source aider
-- https://aider.chat/

return {
  {
    "GeorgesAlkhouri/nvim-aider",
    cmd = "Aider",
    -- Example key mappings for common actions:
    keys = {
      { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
      {
        "<leader>as",
        "<cmd>Aider send<cr>",
        desc = "Send to Aider",
        mode = { "n", "v" },
      },
      { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
      { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
      { "<leader>ai", "<cmd>Aider add<cr>", desc = "Add File" },
      { "<leader>ad", "<cmd>Aider drop<cr>", desc = "Drop File" },
      { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
      { "<leader>aR", "<cmd>Aider reset<cr>", desc = "Reset Session" },
    },
    dependencies = {
      { "folke/snacks.nvim", version = ">=2.24.0" },
      {
        "nvim-neo-tree/neo-tree.nvim",
        opts = function(_, opts)
          -- Example mapping configuration (already set by default)
          opts.window = {
            mappings = {
              ["+"] = { "nvim_aider_add", desc = "add to aider" },
              ["-"] = { "nvim_aider_drop", desc = "drop from aider" },
              ["="] = {
                "nvim_aider_add_read_only",
                desc = "add read-only to aider",
              },
            },
          }

          require("nvim_aider.neo_tree").setup(opts)
        end,
      },
    },
    config = true,
  },
}
