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
        server = {
          cmd = { "rust-analyzer" },
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = false,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              checkOnSave = {
                allFeatures = false,
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
                  ".dart_tool",
                  ".direnv",
                  ".flatpak-builder",
                  ".git",
                  ".github",
                  ".gitlab",
                  ".gitlab-ci",
                  ".gradle",
                  ".idea",
                  ".next",
                  ".project",
                  ".scannerwork",
                  ".settings",
                  ".surfpool",
                  ".opencode",
                  ".venv",
                  "_build",
                  "archetype-resources",
                  "bin",
                  "hooks",
                  "node_modules",
                  "po",
                  "screenshots",
                  "target",
                  "venv",
                },
              },
            },
          },
        },
      }
    end,
  },
}
