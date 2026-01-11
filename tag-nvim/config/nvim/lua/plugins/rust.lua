local utils = require("core.utils")

return {
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = true,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    ft = { "rust", "rs" },
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
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
            },
          },
        },
      }
    end,
  },
}
