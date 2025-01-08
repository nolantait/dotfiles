-- DOCS: Test runner with <Leader>t

return function()
  local neotest = require("neotest")
  local icons = require("globals.icons")

  neotest.setup({
    adapters = {
      require("neotest-python"),
      require("rustaceanvim.neotest"),
      require("neotest-rspec")({
        rspec_cmd = function(position_type)
          if position_type == "test" then
            return vim.tbl_flatten({
              "bundle",
              "exec",
              "rspec",
              "--fail-fast",
            })
          else
            return vim.tbl_flatten({
              "bundle",
              "exec",
              "rspec",
            })
          end
        end,
      }),
    },
    diagnostic = {
      enabled = false,
    },
    floating = {
      border = "rounded",
      max_height = 0.6,
      max_width = 0.9,
    },
    icons = {
      child_indent = "│",
      child_prefix = "├",
      collapsed = "─",
      expanded = "╮",
      failed = icons.cross,
      final_child_indent = " ",
      final_child_prefix = "╰",
      non_collapsible = "─",
      passed = icons.check,
      running = icons.running,
      skipped = icons.skipped,
      unknown = icons.question_mark,
    },
    run = { enabled = true },
    output = {
      enabled = true,
      open_on_run = true,
    },
    quickfix = {
      enabled = true,
      open = function()
        -- vim.cmd("Trouble quickfix")
        -- vim.cmd("TestSummary")
      end,
    },
    status = {
      enabled = true,
      signs = true,
      virtual_text = false,
    },
    strategies = {
      integrated = {
        height = 40,
        width = 120,
      },
    },
    summary = {
      animated = true,
      enabled = true,
      expand_errors = true,
      follow = true,
      mappings = {
        attach = "a",
        expand = { "<CR>", "<2-LeftMouse>" },
        expand_all = "e",
        jumpto = "i",
        output = "o",
        run = "r",
        short = "O",
        stop = "u",
      },
    },
  })

  local neotest_ns = vim.api.nvim_create_namespace("neotest")
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        local message = diagnostic.message
          :gsub("\n", " ")
          :gsub("\t", " ")
          :gsub("%s+", " ")
          :gsub("^%s+", "")
        return message
      end,
    },
  }, neotest_ns)

  vim.cmd("command! TestNearest lua require('neotest').run.run()")
  vim.cmd(
    "command! TestFile lua require('neotest').run.run(vim.fn.expand('%'))"
  )
  vim.cmd("command! TestSummary lua require('neotest').summary.open()")
  vim.cmd(
    "command! TestOutput lua require('neotest').output.open({ enter = true, last_run = true })"
  )
  vim.cmd(
    "command! TestOutputPanel lua require('neotest').output_panel.toggle()"
  )
  vim.cmd("command! TestAttach lua require('neotest').run.attach()")
  vim.cmd("command! TestStop lua require('neotest').run.stop()")
end
