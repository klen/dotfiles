return {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup {
      operators = {
        gc = "Comments",
        ys = "Surround",
        Q = "Format",
      },
    }
  end,
}
