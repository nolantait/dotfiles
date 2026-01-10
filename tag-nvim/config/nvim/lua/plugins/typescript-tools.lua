return {
  {
    "pmizio/typescript-tools.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    ft = { "typescript", "typescriptreact", "typescript.tsx" },
    keys = {
      {
        "gD",
        mode = "n",
        desc = "Go to definition",
        function()
          vim.cmd("TSToolsGoToSourceDefinition")
        end,
      },
    },
  },
}
