local abbreviate_path = function(path)
  local home = require("globals.settings").home
  if path:find(home, 1, true) == 1 then
    path = "~" .. path:sub(#home + 1)
  end
  return path
end

return function()
  return " " .. abbreviate_path(vim.fs.normalize(vim.fn.getcwd()))
end
