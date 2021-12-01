return function()
  local ok, project = pcall(require, "project_nvim")
  if not ok then
    return
  end
  local u = require "utils"

  project.setup {}
  u.command("Projects", "Telescope projects")
end
