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
  local command = vim.api.nvim_create_user_command

  command("ProfileStart", function()
    M.start()
  end, { nargs = 0 })

  command("ProfileStop", function()
    M.stop()
  end, { nargs = 0 })

  local keymap = vim.api.nvim_set_keymap
  local opts = {
    noremap = true,
    silent = true,
  }

  keymap("n", "<Leader>ps", "<cmd>ProfileStart<CR>", opts)
  keymap("n", "<Leader>px", "<cmd>ProfileStart<CR>", opts)
end

return M
