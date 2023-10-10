local M = {}
gem = {}

function M.Detect()
    if vim.fn.empty(vim.fn.glob('*.gemspec')) == 1 then
        return
    end

    gem.path = vim.fn.getcwd()
end

local function lib2spec(file)
    -- Check if the file starts with 'lib/' or contains '/lib/'
    if file:match('^lib/') or file:match('/lib/') then
        -- Replace the 'lib/' part with 'spec/' and append '_spec' before the file extension
        return file:gsub('^lib/', 'spec/'):gsub('/lib/', '/spec/'):gsub('%.rb$', '_spec.rb')
    else
        return file -- Return the same file if it doesn't match the 'lib/' pattern
    end
end

local function spec2lib(file)
    -- Check if the file starts with 'spec/' or contains '/spec/'
    if file:match('^spec/') or file:match('/spec/') then
        -- Replace the 'spec/' part with 'lib/' and remove the '_spec' from the file name
        return file:gsub('^spec/', 'lib/'):gsub('/spec/', '/lib/'):gsub('_spec%.rb$', '.rb')
    else
        return file -- Return the same file if it doesn't match the 'spec/' pattern
    end
end

function M.Alternative()
    local file = vim.fn.expand('%')
    if vim.fn.match(file, '\\v^lib/|/lib/') ~= -1 then
        file = lib2spec(file)
    elseif vim.fn.match(file, '\\v^spec/|/spec/') ~= -1 then
        file = spec2lib(file)
    else
        return
    end

    vim.cmd('edit ' .. vim.fn.fnameescape(file))
end

vim.cmd([[
  command! -nargs=0 A :lua require('plugins.gem').Alternative()
]])

vim.cmd([[
augroup gemPluginDetect
  autocmd!
  autocmd VimEnter * lua require("plugins.gem").Detect()
augroup END
]])

return M
