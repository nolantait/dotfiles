local utils = require("core.utils")

return {
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = true,
  },
  {
    "mrcjkb/rustaceanvim",
    enabled = true,
    version = "^9",
    lazy = false,
    keys = {
      {
        "<Leader>od",
        desc = "Open Rust docs for item under cursor",
        function()
          vim.cmd.RustLsp("openDocs")
        end,
      },
      {
        "<Leader>or",
        desc = "Open related diagnostics",
        function()
          vim.cmd.RustLsp("relatedDiagnostics")
        end,
      },
      {
        "<Leader>oe",
        desc = "Explain rust error",
        function()
          vim.cmd.RustLsp("explainError")
        end,
      },
    },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          float_win_config = {
            border = utils.border("FloatBorder"),
          },
        },
      }
    end,
  },
}
