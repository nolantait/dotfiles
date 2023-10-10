local devicons_ok, devicons = prequire("nvim-web-devicons")
if not devicons_ok then
  return
end

if devicons then
  devicons.setup {}
end
