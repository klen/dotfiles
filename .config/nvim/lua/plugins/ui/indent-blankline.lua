-- Indent guides for Neovim
-- https://github.com/lukas-reineke/indent-blankline.nvim
return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("indent_blankline").setup {
      use_treesitter = true,
      show_first_indent_level = false,
      filetype_exclude = { "", "help", "packer", "starter" },
    }
  end,
}
