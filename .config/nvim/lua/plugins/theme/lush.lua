-- Define Neovim themes as a DSL in lua, with real-time feedback
-- https://github.com/rktjmp/lush.nvim
return {
  "rktjmp/lush.nvim",
  config = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "**/colors/*.lua",
      callback = function()
        --   require("lush").ify()
      end,
    })
  end,
}
