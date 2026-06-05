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
          cmd = function()
            local overridden =
              vim.fn.system("rustup which rust-analyzer"):gsub("\n", "")
            if vim.v.shell_error == 0 and overridden ~= "" then
              return { overridden }
            end
            return { vim.fn.exepath("rust-analyzer") }
          end,
          settings = function(project_root)
            -- Detect Anchor workspaces by the presence of Anchor.toml
            local is_anchor = vim.fn.filereadable(
              project_root .. "/Anchor.toml"
            ) == 1

            local cargo = {
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            }
            local check = {
              command = "clippy",
              extraArgs = {
                "--",
                "-D",
                "clippy::pedantic",
                "-D",
                "clippy::nursery",
                "--no-deps",
              },
            }

            if is_anchor then
              -- allFeatures would enable idl-build on anchor-syn, which calls
              -- Span::local_file() — a nightly-only API that crashes the
              -- proc-macro server on stable. Use an explicit feature list instead.
              -- devnet is excluded: we run against mainnet via surfnet.
              cargo.features = { "cpi" }
              -- clippy never reaches all crates due to .clippy.toml denying
              -- pedantic/nursery — use cargo check instead.
              check = { command = "check" }
            else
              cargo.allFeatures = true
            end

            return {
              ["rust-analyzer"] = {
                check = check,
                cargo = cargo,
                checkOnSave = {
                  allFeatures = not is_anchor,
                  command = is_anchor and "check" or "clippy",
                  extraArgs = is_anchor and {} or { "--no-deps" },
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
                    "venv",
                    ".venv",
                  },
                },
              },
            }
          end,
        },
      }
    end,
  },
}
