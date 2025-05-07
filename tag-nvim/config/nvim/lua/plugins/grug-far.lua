-- DOCS: Gurg find and replace

return {
  {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar" },
    event = "LazyFile",
    keys = {
      {
        "<Leader>rf",
        mode = { "n", "v" },
        desc = "Grug find and replace in file",
        function()
          require("grug-far").open({
            transient = true,
            prefills = { paths = vim.fn.expand("%") },
          })
        end,
      },
      {
        "<Leader>ra",
        mode = "n",
        desc = "Grug find and replace in all files",
        function()
          require("grug-far").open({
            transient = true,
          })
        end,
      },
    },
  },
}
