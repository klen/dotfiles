return {
  -- Adding a filename to the Top Right
  {
    "b0o/incline.nvim",
    enabled = true,
    event = 'VeryLazy',
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      hide = {
        only_win = false,
      },
      render = function(props)
        local miniIcons = require("mini.icons")
        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local filename = vim.fn.fnamemodify(bufname, ":t")
        if filename == '' then filename = '[No Name]' end

        local icon, icon_color = miniIcons.get("file", bufname)

        local modified = vim.bo[props.buf].modified

        return {
          { " ",      icon,                               " ", guifg = icon_color },
          { filename, gui = modified and "bold" or "none" },
          modified and { " [+]", guifg = "#ff9e64" } or "",
          " ",
        }
      end,
    }
  }
}
