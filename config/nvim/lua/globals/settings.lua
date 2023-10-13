local os_name = vim.loop.os_uname().sysname
local is_windows = os_name == "Windows_NT"
local path_sep = is_windows and "\\" or "/"
local home = is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
local vim_path = vim.fn.stdpath("config")

return {
  home = home,
  data_dir = vim.fn.stdpath("data"),
  vim_path = vim_path,
  cache_dir = home .. path_sep .. ".cache" .. path_sep .. "nvim" .. path_sep,
  modules_dir = vim_path .. path_sep .. "modules",
}
