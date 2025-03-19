-- DOCS: Custom plugin to provide rails.vim style keybids to rails projects

local M = {}
M.app = {}

-- Go from a file in lib/ and find the matching spec in spec/
local function file2spec(file)
  -- Check if the file starts with 'app/' or contains '/app/'
  if file:match("^app/") or file:match("/app/") then
    -- Replace the 'app/' part with 'spec/' and append '_spec' before the file extension
    local path = file
      :gsub("^app/", "spec/")
      :gsub("/app/", "/spec/")
      :gsub("%.rb$", "_spec.rb")

    return path
  else
    return file -- Return the same file if it doesn't match the 'app/' pattern
  end
end

-- Go from a file in spec/ and find the matching file in app/
local function spec2file(file)
  -- Check if the file starts with 'spec/' or contains '/spec/'
  if file:match("^spec/") or file:match("/spec/") then
    -- Replace the 'spec/' part with 'app/' and remove the '_spec' from the file name
    local path = file
      :gsub("^spec/", "app/")
      :gsub("/spec/", "/app/")
      :gsub("_spec%.rb$", ".rb")

    return path
  else
    return file -- Return the same file if it doesn't match the 'spec/' pattern
  end
end

-- Detect if we are in a ruby project
function M.detect()
  local app = vim.fn.glob("config/application.rb")

  if vim.fn.empty(app) == 1 then
    return
  end

  M.app.path = vim.fn.getcwd()
end

-- Allows usage of :A to navigate to alternative files depending on where
-- we are.
function M.alternative()
  local file = vim.fn.expand("%")

  if vim.fn.match(file, "\\v^app/|/app/") ~= -1 then
    file = file2spec(file)
  elseif vim.fn.match(file, "\\v^spec/|/spec/") ~= -1 then
    file = spec2file(file)
  else
    return
  end

  vim.cmd("edit " .. vim.fn.fnameescape(file))
end

function M.setup()
  -- Set up our command as :A
  vim.api.nvim_create_user_command("A", function()
    M.alternative()
  end, { nargs = 0 })

  -- Run detection anytime we navigate to a file to see if we are in a ruby
  -- project
  local augroup = vim.api.nvim_create_augroup("rails_plugin", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
    pattern = "*",
    group = augroup,
    callback = function()
      M.detect()
    end,
  })
end

return M
