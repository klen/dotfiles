return {
  "b0o/incline.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {
    hide = {
      -- focused_win = true,
    },
    window = {
      placement = {
        vertical = "bottom",
      },
    },
    render = function(props)
      local bufname = vim.api.nvim_buf_get_name(props.buf)
      local filename = vim.fn.fnamemodify(bufname, ":t")
      if filename == "" then
        filename = "[No Name]"
      end

      local modified = vim.bo[props.buf].modified

      return {
        { filename, gui = modified and "bold" or "none" },
        modified and { " [+]", guifg = "#ff9e64" } or "",
        " ",
      }
    end,
  },
}
