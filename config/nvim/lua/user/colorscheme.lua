local ok, base16 = prequire("base16-colorscheme")
if not ok then
  return
end

if base16 then
  -- Start flavours
  -- Base16 OneDark
  -- Author: Lalit Magant (http://github.com/tilal6991)
  -- Sets up the theme for base16-vim

  base16.setup({
    base00 = '#282c34',
    base01 = '#353b45',
    base02 = '#3e4451',
    base03 = '#545862',
    base04 = '#565c64',
    base05 = '#abb2bf',
    base06 = '#b6bdca',
    base07 = '#c8ccd4',
    base08 = '#e06c75',
    base09 = '#d19a66',
    base0A = '#e5c07b',
    base0B = '#98c379',
    base0C = '#56b6c2',
    base0D = '#61afef',
    base0E = '#c678dd',
    base0F = '#be5046',
  })
  -- End flavours

  -- Sets MatchParen from matchup to be a more subdued gray
  local color = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('CursorLineNr')), 'bg')
  vim.api.nvim_command("hi MatchParen guibg=" .. color)
end


