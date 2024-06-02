local M = {}

function M.start()
  vim.cmd("profile start ~/dotfiles/config/nvim/profile.log")
  vim.cmd("profile func *")
  vim.cmd("profile file *")
end

function M.stop()
  vim.cmd("profile stop")
end

function M.setup()
  vim.cmd([[
    command! -nargs=0 ProfileStart :lua require('custom.profiling').start()
    command! -nargs=0 ProfileStop :lua require('custom.profiling').stop()
  ]])

  local keymap = vim.api.nvim_set_keymap
  local opts = {
    noremap = true,
    silent = true
  }

  keymap("n", "<Leader>ps", "<cmd>ProfileStart<CR>", opts)
  keymap("n", "<Leader>px", "<cmd>ProfileStart<CR>", opts)
end

return M
