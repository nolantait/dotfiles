function startProfile()
  vim.cmd("profile start ~/.config/nvim/profile.log")
  vim.cmd("profile func *")
  vim.cmd("profile file *")
end

function stopProfile()
  vim.cmd("profile pause")
  vim.cmd("profile! ~/.config/nvim/profile.log")
end

vim.cmd("command! StartProfile lua startProfile()")
vim.cmd("command! StopProfile lua stopProfile()")
