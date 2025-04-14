return function()
  local cursorline = vim.fn.line(".")
  local cursorcol = vim.fn.virtcol(".")
  local filelines = vim.fn.line("$")
  local position
  if cursorline == 1 then
    position = "Top"
  elseif cursorline == filelines then
    position = "Bot"
  else
    position =
      string.format("%2d%%%%", math.floor(cursorline / filelines * 100))
  end
  return string.format("%s%3d:%-2d", position, cursorline, cursorcol)
end
