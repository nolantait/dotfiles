-- Adds StartProfile and StopProfile commands to profile neovim plugins

function StartProfile()
  vim.cmd("profile start ~/.config/nvim/profile.log")
  vim.cmd("profile func *")
  vim.cmd("profile file *")
end

function StopProfile()
  vim.cmd("profile pause")
  vim.cmd("profile! ~/.config/nvim/profile.log")
end

vim.cmd("command! StartProfile lua StartProfile()")
vim.cmd("command! StopProfile lua StopProfile()")
