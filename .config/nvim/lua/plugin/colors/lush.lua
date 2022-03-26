-- Define Neovim themes as a DSL in lua, with real-time feedback
-- https://github.com/rktjmp/lush.nvim
return {
  "rktjmp/lush.nvim",
  config = function()
    -- Lushify
    vim.cmd [[
        augroup packer_user_config
          autocmd!
          autocmd BufEnter **/colors/*.lua Lushify
        augroup end
      ]]
  end,
}
