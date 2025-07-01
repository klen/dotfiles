return {
  "echasnovski/mini.icons",
  lazy = true,
  config = function()
    require("mini.icons").setup({})

    -- Set up custom highlights for icons
    local hi = vim.api.nvim_set_hl
    hi(0, "MiniIconsRed", { link = "Comment" })
    hi(0, "MiniIconsGreen", { link = "Directory" })
    hi(0, "MiniIconsYellow", { link = "Comment" })
    hi(0, "MiniIconsOrange", { link = "Comment" })
  end,
}
