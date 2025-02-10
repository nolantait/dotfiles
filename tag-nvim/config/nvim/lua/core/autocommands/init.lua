-- DOCS: This will setup all of our autocommands
-- Autocommands are events that happen in vim, like a file opening or closing
-- We can use these events to trigger functions automatically

local M = {}

-- This will prefix our autocommands to namespace them to run first
local function augroup(name)
  local augroup_name = "_" .. name
  return vim.api.nvim_create_augroup(augroup_name, { clear = true })
end

function M.setup()
  local command = vim.api.nvim_create_autocmd

  command("ModeChanged", {
    desc = "Hide relative numbers when neither linewise/blockwise mode is on",
    group = augroup("relative_numbers"),
    pattern = "[V\x16]*:*",
    callback = function()
      local matching = string.find(vim.fn.mode(), "^[V\22]") ~= nil
      vim.wo.relativenumber = matching
    end,
  })

  command("ModeChanged", {
    desc = "Show relative numbers only when they matter",
    group = augroup("relative_numbers"),
    pattern = "*:[V\x16]*",
    callback = function()
      vim.wo.relativenumber = vim.wo.number
    end,
  })

  command("TermOpen", {
    callback = require("core.autocommands.terminal_insert_mode"),
    desc = "Open terminal in insert mode",
    group = augroup("terminal_insert_mode"),
    pattern = "term://*",
  })

  command("TextYankPost", {
    callback = require("core.autocommands.highlight_on_yank"),
    desc = "Highlight yanked text",
    group = augroup("highlightyank"),
    pattern = "*",
  })

  command("VimResized", {
    callback = require("core.autocommands.resize_splits"),
    desc = "Resize splits if window gets resized",
    group = augroup("resize_splits"),
  })

  command("BufReadPost", {
    group = augroup("auto_jump_last"),
    callback = require("core.autocommands.auto_jump_last"),
    desc = "Auto jump to last cursor position",
  })

  command("FileType", {
    callback = require("core.autocommands.close_with_q"),
    desc = "Close some filetypes with <q>",
    group = augroup("close_with_q"),
    pattern = {
      "PlenaryTestPopup",
      "checkhealth",
      "help",
      "lspinfo",
      "man",
      "neotest-output",
      "neotest-output-panel",
      "neotest-summary",
      "notify",
      "qf",
      "lazy",
      "spectre_panel",
      "startuptime",
      "tsplayground",
    },
  })

  command("FileType", {
    callback = require("core.autocommands.turn_on_spellcheck"),
    desc = "Wrap and check for spell in text filetypes",
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown" },
  })

  command("BufWritePre", {
    callback = require("core.autocommands.create_directories"),
    desc = "Auto create dir when saving a file",
    group = augroup("auto_create_dir"),
  })

  command({ "FocusGained", "TermClose", "TermLeave" }, {
    command = "checktime",
    desc = "Check if we need to reload the file when it changed",
    group = augroup("checktime"),
  })

  command({ "BufNewFile", "BufRead" }, {
    desc = "Set the i3 filetype based on the file extension",
    group = augroup("detect_i3"),
    pattern = "*.i3.config",
    callback = function()
      vim.bo.filetype = "i3config"
    end,
  })

  command({ "BufNewFile", "BufRead" }, {
    desc = "Set the sway filetype based on the file extension",
    group = augroup("detect_sway"),
    pattern = "*.sway.config",
    callback = function()
      vim.bo.filetype = "i3config"
    end,
  })

  command({ "BufNewFile", "BufRead" }, {
    desc = "Set the ansible filetype based on the project",
    group = augroup("detect_ansible"),
    pattern = "*.yml,*.yaml",
    callback = require("core.autocommands.ansible_filetype"),
  })

  command({ "BufNewFile", "BufRead" }, {
    desc = "Set the Brewfile filetype",
    group = augroup("detect_brewfile"),
    pattern = "Brewfile",
    callback = function()
      vim.bo.filetype = "ruby"
    end,
  })
end

return M
