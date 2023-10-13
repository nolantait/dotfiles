return function()
  local nvim_test = require("nvim-test")

  nvim_test.setup({
    run = true,               -- run tests (using for debug)
    commands_create = true,   -- create commands (TestFile, TestLast, ...)
    -- filename_modifier = ":.", -- modify filenames before tests run(:h filename-modifiers)
    silent = false,           -- less notifications
    term = "terminal",        -- a terminal to run ("terminal"|"toggleterm")
    termOpts = {
      direction = "float", -- terminal's direction ("horizontal"|"vertical"|"float")
      width = 100,             -- terminal's width (for vertical|float)
      height = 50,            -- terminal's height (for horizontal|float)
      go_back = false,        -- return focus to original window after executing
      stopinsert = "auto",    -- exit from insert mode (true|false|"auto")
      keep_one = true,        -- keep only one terminal for testing
    },
    runners = {               -- setup tests runners
      lua = "nvim-test.runners.busted",
      ruby = "nvim-test.runners.rspec",
    }
  })

  require("nvim-test.runners.rspec"):setup({
    command = "bin/rspec",
    args = {},
    -- env = {},
    file_pattern = "%_spec.rb",
    find_files = { "{name}_spec.rb" }
  })
end
