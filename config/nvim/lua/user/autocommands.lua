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

vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end
  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end
  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end
]]

local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text briefly when yoinked
cmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("highlightyank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end
})

-- Auto jump to last cursor position
cmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
