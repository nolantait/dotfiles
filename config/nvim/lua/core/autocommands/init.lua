-- DOCS: This will setup all of our autocommands
-- Autocommands are events that happen in vim, like a file opening or closing
-- We can use these events to trigger functions automatically

local cmd = vim.api.nvim_create_autocmd

-- This will prefix our autocommands to namespace them to run first
local function augroup(name)
  return vim.api.nvim_create_augroup("_" .. name, { clear = true })
end

cmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("highlightyank"),
  pattern = "*",
  callback = require("core.autocommands.highlight_on_yank")
})

cmd("VimResized", {
  desc = "Resize splits if window gets resized",
  group = augroup("resize_splits"),
  callback = require("core.autocommands.resize_splits"),
})

cmd("BufReadPost", {
  desc = "Auto jump to last cursor position",
  callback = require("core.autocommands.auto_jump_last"),
})

cmd("FileType", {
  desc = "Close some filetypes with <q>",
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = require("core.autocommands.close_with_q"),
})

cmd("FileType", {
  desc = "Wrap and check for spell in text filetypes",
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = require("core.autocommands.turn_on_spellcheck"),
})

cmd("BufWritePre", {
  desc = "Auto create dir when saving a file",
  group = augroup("auto_create_dir"),
  callback = require("core.autocommands.create_directories"),
})

cmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if we need to reload the file when it changed",
  group = augroup("checktime"),
  command = "checktime",
})
