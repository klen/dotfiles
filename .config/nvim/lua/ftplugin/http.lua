local u = require "utils"
local M = {}

function M.setup()
  u.lua_command("-buffer Run", "require('rest-nvim').run()")
  u.lua_command("-buffer RunPreview", "require('rest-nvim').run(true)")
  vim.bo.commentstring = "# %s"
end

return M
