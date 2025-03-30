local detect_ansible = function(path)
  local dir = path

  while dir ~= "/" do
    if vim.fn.filereadable(dir .. "/.git") == 1 then
      return "yaml.ansible"
    end

    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return "yaml"
end

vim.filetype.add({
  extension = {
    -- Add new filetype for .i3.config files
    ["i3.config"] = "i3config",
    ["sway.config"] = "i3config",
    yml = detect_ansible,
    yaml = detect_ansible,
  },
  filename = {
    -- Add new filetype for specific filenames
    ["Brewfile"] = "ruby"
  },
  pattern = {
    -- Add new filetype for files matching a pattern
    -- ["~/projects/myproject/*"] = "myfiletype",
  },
})
