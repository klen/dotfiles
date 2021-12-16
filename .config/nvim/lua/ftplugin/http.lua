local tools = require "tools"
local M = {}

function M.setup()
  tools.lua_command("-buffer Run", "require('rest-nvim').run()")
  tools.lua_command("-buffer RunPreview", "require('rest-nvim').run(true)")
  vim.bo.commentstring = "# %s"
end

return M
