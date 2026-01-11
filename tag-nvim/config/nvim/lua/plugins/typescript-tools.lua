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
      {
        "<Leader>F",
        desc = "Add missing imports",
        function()
          vim.cmd("TSToolsAddMissingImports")
        end,
      },
      {
        "<Leader>di",
        desc = "Remove unused imports",
        function()
          vim.cmd("TSToolsRemoveUnusedImports")
        end,
      },
      {
        "<Leader>rt",
        desc = "Rename current file",
        function()
          vim.cmd("TSToolsRenameFile")
        end,
      },
      {
        "gR",
        desc = "Find references to the current file",
        function()
          vim.cmd("TSToolsFileReferences")
        end,
      },
    },
  },
}
