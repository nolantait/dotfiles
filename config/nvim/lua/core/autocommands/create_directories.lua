-- DOCS: This will create any directories that don't exist when saving a file

return function(event)
  -- Don't do anything if the file already exists
  if event.match:match("^%w%w+://") then
    return
  end

  -- Get the full path of the file
  local file = vim.loop.fs_realpath(event.match) or event.match

  -- Get the directory of the file
  local path = vim.fn.fnamemodify(file, ":p:h")

  -- Create the directory with -p (parents), basically `mkdir -p path`
  vim.fn.mkdir(path, "p")
end
