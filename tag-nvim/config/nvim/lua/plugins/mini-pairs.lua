-- DOCS: Minimal and fast autopairs

local config = function()
  local mini_pairs = require("mini.pairs")

  local opts = {
    modes = { insert = true, command = true, terminal = false },
    -- Skip autopair when next character is one of these
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    -- Skip autopair when cursor is inside these treesitter nodes
    skip_ts = { "string" },
    -- Skip autopair when next character is a closing pair and there are more
    -- closing pairs than opening
    skip_unbalanced = true,
    -- Handle markdown code blocks
    markdown = true,
  }

  mini_pairs.setup({
    -- In which modes mappings from this `config` should be created
    modes = { insert = true, command = true, terminal = false },
  })

  -- https://github.com/LazyVim/LazyVim/blob/12818a6cb499456f4903c5d8e68af43753ebc869/lua/lazyvim/util/mini.lua#L123
  local open = mini_pairs.open
  mini_pairs.open = function(pair, neigh_pattern)
    -- If we are in command mode, we are probably trying to type a command
    if vim.fn.getcmdline() ~= "" then
      return open(pair, neigh_pattern)
    end

    local opening, closing = pair:sub(1, 1), pair:sub(2, 2)
    local line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local next = line:sub(cursor[2] + 1, cursor[2] + 1)
    local before = line:sub(1, cursor[2])

    if
      opts.markdown
      and opening == "`"
      and vim.bo.filetype == "markdown"
      and before:match("^%s*``")
    then
      return "`\n```"
        .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
    end

    if opts.skip_next and next ~= "" and next:match(opts.skip_next) then
      return opening
    end

    if opts.skip_ts and #opts.skip_ts > 0 then
      local ok, captures = pcall(
        vim.treesitter.get_captures_at_pos,
        0,
        cursor[1] - 1,
        math.max(cursor[2] - 1, 0)
      )

      for _, capture in ipairs(ok and captures or {}) do
        if vim.tbl_contains(opts.skip_ts, capture.capture) then
          return opening
        end
      end
    end

    if opts.skip_unbalanced and next == closing and closing ~= opening then
      local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
      local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")

      if count_close > count_open then
        return opening
      end
    end

    return open(pair, neigh_pattern)
  end

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup(
      "rust_disable_single_quote_pairs",
      { clear = true }
    ),
    pattern = "rust",
    callback = function()
      vim.keymap.set("i", "'", "'", { buffer = 0 })
    end,
  })
end

return {
  {
    "nvim-mini/mini.pairs",
    config = config,
    lazy = false,
  },
}
