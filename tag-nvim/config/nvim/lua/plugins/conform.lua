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
    async = false,
    quiet = false,
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
      notify_on_error = true,
      formatters_by_ft = {
        bash = { "shfmt" },
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier", lsp_format = "fallback" },
        javascriptreact = { "prettier", lsp_format = "fallback" },
        json = { "prettier", stop_on_first = true },
        jsonc = { "prettier", stop_on_first = true },
        lua = { "stylua" },
        markdown = { "trim_whitespace", "trim_newlines" },
        sh = { "shfmt" },
        svg = { "htmlbeautifier" },
        toml = { "prettier" },
        typescript = { "prettier", lsp_format = "fallback" },
        typescriptreact = { "prettier", lsp_format = "fallback" },
        zsh = { lsp_format = "fallback" },
      },
    },
  },
}
