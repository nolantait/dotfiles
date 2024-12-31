-- DOCS: Detects ansible filetypes
-- lua/ansible-filetype.lua
local M = {}

-- Helper function to find the root directory containing ansible.cfg
M.find_ansible_cfg_dir = function()
  local cwd = vim.fn.getcwd()
  local dir = cwd

  while dir ~= "/" do
    if vim.fn.filereadable(dir .. "/ansible.cfg") == 1 then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return nil
end

return function()
  local ansible_root = M.find_ansible_cfg_dir()
  if ansible_root then
    vim.bo.filetype = "yaml.ansible"
  end
end
