local plugins_path = vim.fn.stdpath "data" .. "/site/pack/packer/start"
local plugins_count = vim.fn.len(vim.fn.globpath(plugins_path, "*", 0, 1))
local default_footer = [[
Type query to filter items
<BS> deletes latest character from query
<Down>/<Up> and <M-j>/<M-k> move current item
<CR> executes action of current item
<C-c> closes this buffer]]

local starter = require "mini.starter"
starter.setup {
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.aligning("center", "center"),
  },
  items = {
    starter.sections.recent_files(10, true),
    starter.sections.sessions(5, true),

    -- Custom actions
    { name = "Find files", action = "Telescope find_files", section = "Actions" },
    { name = "Live grep", action = "Telescope live_grep", section = "Actions" },
    { name = "Update plugins", action = "PackerSync", section = "Actions" },
    { name = "Edit new", action = "enew", section = "Actions" },
    { name = "Quit Neovim", action = "qall", section = "Actions" },
  },
  header = function()
    local hour = tonumber(fn.strftime "%H")
    -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
    local part_id = math.floor((hour + 4) / 8) + 1
    local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
    return ("Good %s, Kirill"):format(day_part)
  end,
  footer = ("Loaded " .. plugins_count .. " plugins. " .. "Load time: " .. fn.printf(
    "%.3f",
    fn.reltimefloat(fn.reltime(vim.g.start_time))
  ) .. " seconds.\n\n" .. default_footer),
}
