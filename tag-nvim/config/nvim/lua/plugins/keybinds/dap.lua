return {
  {
    mode = "n",
    key = "<Leader>;",
    command = "<cmd>lua require'dap'.continue()<CR>",
    description = "DAP Continue debugging",
  },
  {
    mode = "n",
    key = "<Leader>]",
    command = "<cmd>lua require'dap'.step_over()<CR>",
    description = "DAP Step over",
  },
  {
    mode = "n",
    key = "<Leader>du",
    command = "<cmd>lua require('dapui').toggle()<CR>",
    description = "Toggle nvim-dap-ui",
  },
  {
    mode = "n",
    key = "<Leader>de",
    command = "<cmd>lua require('dapui').eval()<CR>",
    description = "Eval with nvim-dap-ui",
  },
  {
    mode = "n",
    key = "<Leader>da",
    command = "<cmd>lua require('dap').restart()<CR>",
    description = "DAP restart",
  },
  {
    mode = "n",
    key = "<Leader>dh",
    command = "<cmd>lua require'dap.ui.widgets'.hover()<CR>",
    description = "DAP hover variables",
  },
  {
    mode = "n",
    key = "<Leader>dr",
    command = "<cmd>lua require('dapui').float_element('repl', { width = 100, height = 20, enter = true, position = 'center' })<CR>",
    description = "DAP REPL toggle",
  },
  {
    mode = "n",
    key = "<Leader>db",
    command = "<cmd>lua require('dap').toggle_breakpoint()<CR>",
    description = "DAP toggle breakpoint",
  },
  {
    mode = "n",
    key = "<Leader>dc",
    command = "<cmd>lua require('dap').run_to_cursor()<CR>",
    description = "DAP run to cursor",
  },
}
