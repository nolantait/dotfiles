-- Command: `autocmd BufWinEnter * :set formatoptions-=cro`
--
-- Explanation:
-- formatoptions is a Vim option that controls various text formatting behaviors.
--  c stands for 'auto-wrap comments', which means Vim will automatically break long comments into multiple lines.
--  r stands for 'auto-insert comment continuation character', which inserts the comment continuation character (\) automatically when you press Enter in a comment.
--  o stands for 'auto-insert comment leaders', which inserts comment leader characters (*, #, etc.) automatically when you start a new line in a comment.
-- The :set formatoptions-=cro command effectively disables these three formatting options when entering a buffer window. It can be used to control how comments are formatted in your code.


-- Command: `autocmd FileType qf set nobuflisted`
--
-- Explanation:
-- nobuflisted is a Vim option that controls whether the buffer is listed in the buffer list. When a buffer is listed, it can be accessed using commands like :bnext or :bprev. Setting it to nobuflisted means the buffer for Quickfix windows won't be included in the buffer list, making it less cluttered.

local cmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("_" .. name, { clear = true })
end

cmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("highlightyank"),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end
})

cmd("VimResized", {
  desc = "Resize splits if window gets resized",
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

cmd("BufReadPost", {
  desc = "Auto jump to last cursor position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
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
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

cmd("FileType", {
  desc = "Wrap and check for spell in text filetypes",
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

cmd("BufWritePre", {
  desc = "Auto create dir when saving a file",
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

cmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if we need to reload the file when it changed",
  group = augroup("checktime"),
  command = "checktime",
})
