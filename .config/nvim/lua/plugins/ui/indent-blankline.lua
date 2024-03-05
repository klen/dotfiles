-- Indent guides for Neovim
-- https://github.com/lukas-reineke/indent-blankline.nvim
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    scope = {
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = { "", "help", "packer", "starter" },
    },
  },
}
