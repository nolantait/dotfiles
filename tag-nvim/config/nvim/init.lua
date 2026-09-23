-- DOCS: This is our main entrypoint for our setup. Neovim will load this file
-- first and this file is responsible for loading everything else

-- Load core config
require("core.init").setup()

-- Load plugins with lazy
require("load-plugins").setup()

-- Enable relevant LSP servers
-- These are configured in `after/lsp/*.lua`
--
-- Rust is handled by rustacean.nvim
--
-- Only enable a server whose command is actually installed, otherwise
-- `vim.lsp.enable` logs an "invalid config" error on every startup for each
-- missing binary (ansible, docker, ruff, ty, ...). Install the missing ones with
-- `:MasonInstall <name>` (see `lua/plugins/lsp.lua`).
local servers = {
  "ansible",
  "bash",
  "copilot_ls",
  "css",
  "docker",
  "eslint",
  "lua",
  "python_ruff",
  "python_ty",
  "ruby",
  "godot",
  -- "rust",
}

local function is_installed(name)
  local config = vim.lsp.config[name]
  local cmd = config and config.cmd

  -- Function commands (socket/in-process servers like godot) are always valid.
  if type(cmd) ~= "table" then
    return true
  end

  return vim.fn.executable(cmd[1]) == 1
end

vim.lsp.enable(vim.tbl_filter(is_installed, servers))
