-- DOCS: Sets up auto formatting for files

local format = function(args)
  local range = nil

  if args.count ~= -1 then
    local end_line =
      vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end

  require("conform").format({
    async = true,
    lsp_fallback = true,
    range = range,
  })
end

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    init = function()
      vim.api.nvim_create_user_command("Format", format, { range = true })
    end,
    keys = {
      {
        "<leader>f",
        function()
          vim.cmd("Format")
        end,
        desc = "LSP format with conform",
      },
    },
    opts = {
      formatters_by_ft = {
        javascript = { "prettier", lsp_format = "fallback" },
        javascriptreact = { "prettier", lsp_format = "fallback" },
        typescriptreact = { "prettier", lsp_format = "fallback" },
        typescript = { "prettier", lsp_format = "fallback" },
        json = { "prettier", stop_on_first = true },
        jsonc = { "prettier", stop_on_first = true },
        lua = { "stylua" },
        html = { "htmlbeautifier" },
        svg = { "htmlbeautifier" },
        markdown = { "trim_whitespace", "trim_newlines" },
      },
    },
  },
}
