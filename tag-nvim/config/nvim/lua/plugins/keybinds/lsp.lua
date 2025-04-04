return {
  {
    mode = "n",
    key = "<C-n>",
    command = "<cmd>pop<CR>",
    description = "Pop the last entry from the jump list",
  },
  {
    mode = "n",
    key = "gD",
    command = "<cmd>lua vim.lsp.buf.declaration()<CR>",
    description = "Go to declaration",
  },
  {
    mode = "n",
    key = "gd",
    command = "<cmd>lua vim.lsp.buf.definition()<CR>",
    description = "LSP go to definition",
  },
  {
    mode = "n",
    key = "gi",
    command = "<cmd>lua vim.lsp.buf.implementation()<CR>",
    description = "LSP go to implementation",
  },
  {
    mode = "n",
    key = "<leader>ca",
    command = "<cmd>lua vim.lsp.buf.code_action()<CR>",
    description = "LSP code action",
  },
  {
    mode = "n",
    key = "<leader>cl",
    command = "<cmd>lua vim.lsp.codelens.run()<CR>",
    description = "LSP code lens",
  },
  {
    mode = "n",
    key = "K",
    command = "<cmd>lua vim.lsp.buf.hover()<CR>",
    description = "LSP Hover",
  },
  {
    mode = "n",
    key = "<C-k>",
    command = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    description = "LSP Signature help",
  },
  {
    mode = "n",
    key = "gr",
    command = "<cmd>lua vim.lsp.buf.references()<CR>",
    description = "LSP references",
  },
  {
    mode = "n",
    key = "<leader>rn",
    command = "<cmd>lua vim.lsp.buf.rename()<CR>",
    description = "LSP rename",
  },
  -- {
  --   mode = "n",
  --   key = "<leader>f",
  --   command = "<cmd>lua vim.lsp.buf.format({async=true})<CR>",
  --   description = "LSP format"
  -- },
  {
    mode = "n",
    key = "gt",
    command = "<cmd>lua vim.lsp.buf.type_definition()<CR>",
    description = "LSP type definition",
  },
  {
    mode = "n",
    key = "?",
    command = "<cmd>lua vim.diagnostic.open_float({max_height=400})<CR>",
    description = "Open diagnostic float window",
  },
  {
    mode = "n",
    key = "[d",
    command = "<cmd>lua vim.diagnostic.goto_prev()<CR>",
    description = "Go to previous diagnostic",
  },
  {
    mode = "n",
    key = "]d",
    command = "<cmd>lua vim.diagnostic.goto_next()<CR>",
    description = "Go to next diagnostic",
  },
}
