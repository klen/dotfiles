local starter = require "mini.starter"
local plugins_count

if fn.has "win32" == 1 then
  plugins_count = fn.len(fn.globpath("~/AppData/Local/nvim-data/site/pack/packer/start", "*", 0, 1))
else
  plugins_count = fn.len(fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
end

---@diagnostic disable: undefined-global
local projects = function()
  local history = require "project_nvim.utils.history"
  local project = require "project_nvim.project"
  local builtin = require "telescope.builtin"
  local fmodify = fn.fnamemodify

  local recent = table.reverse(history.get_recent_projects())
  local ret = {}
  for idx, dir in pairs(recent) do
    local path = (" (%s)"):format(fmodify(dir, ":~:.")) or ""
    local name = ("%s%s"):format(fmodify(dir, ":t"), path)
    table.insert(ret, {
      name = name,
      section = "Recent projects",
      action = function()
        MiniStarter.close()
        project.set_pwd(dir, "telescope")
        builtin.find_files { cwd = dir }
      end,
    })
    -- Limit to 20 results
    if idx == 20 then
      break
    end
  end
  return ret
end

starter.setup {
  items = {
    starter.sections.recent_files(10, true),
    -- starter.sections.sessions(5, true),

    projects,

    -- Custom actions
    { name = "Find files", action = "Telescope find_files", section = "Actions" },
    { name = "Live grep", action = "Telescope live_grep", section = "Actions" },
    { name = "Sync Plugins", action = "PackerSync", section = "Actions" },
    { name = "Edit new buffer", action = "enew", section = "Actions" },
    { name = "Quit Neovim", action = "qall", section = "Actions" },
  },

  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.aligning("center", "center"),
  },
  header = function()
    local hour = tonumber(fn.strftime "%H")
    -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
    local part_id = math.floor((hour + 4) / 8) + 1
    local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
    return ("Good %s, Kirill"):format(day_part)
  end,
  footer = "Loaded " .. plugins_count .. " plugins",
}

api.nvim_exec(
  [[
  hi link MiniStarterFooter Whitespace
]],
  false
)
