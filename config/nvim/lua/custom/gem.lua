-- DOCS: Custom plugin to provide rails.vim style keybids to normal gem projects

local M = {}
M.gem = {}

-- Go from a file in lib/ and find the matching spec in spec/
local function lib2spec(file)
  -- Check if the file starts with 'lib/' or contains '/lib/'
  if file:match('^lib/') or file:match('/lib/') then
    -- Replace the 'lib/' part with 'spec/' and append '_spec' before the file extension
    return file:gsub('^lib/', 'spec/'):gsub('/lib/', '/spec/'):gsub('%.rb$', '_spec.rb')
  else
    return file     -- Return the same file if it doesn't match the 'lib/' pattern
  end
end

-- Go from a file in spec/ and find the matching file in lib/
local function spec2lib(file)
  -- Check if the file starts with 'spec/' or contains '/spec/'
  if file:match('^spec/') or file:match('/spec/') then
    -- Replace the 'spec/' part with 'lib/' and remove the '_spec' from the file name
    return file:gsub('^spec/', 'lib/'):gsub('/spec/', '/lib/'):gsub('_spec%.rb$', '.rb')
  else
    return file     -- Return the same file if it doesn't match the 'spec/' pattern
  end
end

-- Detect if we are in a ruby project
function M.detect()
  if vim.fn.empty(vim.fn.glob('*.gemspec')) == 1 then
    return
  end

  M.gem.path = vim.fn.getcwd()
end

-- Allows usage of :A to navigate to alternative files depending on where
-- we are.
function M.alternative()
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

function M.setup()
  -- Set up our command as :A
  vim.api.nvim_create_user_command(
    "A",
    function()
      M.alternative()
    end,
    { nargs = 0 }
  )

  -- Run detection anytime we navigate to a file to see if we are in a ruby
  -- project
  local augroup = vim.api.nvim_create_augroup("gem_plugin", { clear = true })
  vim.api.nvim_create_autocmd(
    { "BufEnter", "BufRead" },
    {
      pattern = "*",
      group = augroup,
      callback = function()
        M.detect()
      end
    }
  )
end

return M
