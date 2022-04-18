local rest = require "rest-nvim"

vim.api.nvim_buf_create_user_command(0, "Run", function()
  rest.run()
end, {})
vim.api.nvim_buf_create_user_command(0, "RunPreview", function()
  rest.run(true)
end, {})
vim.bo.commentstring = "# %s"
