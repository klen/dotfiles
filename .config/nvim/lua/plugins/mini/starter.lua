local fn = vim.fn
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
    -- starter.sections.sessions(5, true),

    -- Custom actions
    { name = "New file", action = "enew", section = "Actions" },
    { name = "Find files", action = "Telescope find_files", section = "Actions" },
    { name = "Daily Note", action = "ObsidianToday", section = "Actions" },
    {
      name = "Plugins manage",
      action = function()
        local lazy = require "lazy"
        lazy.home()
      end,
      section = "Actions",
    },
    { name = "Treesitter update", action = "TSUpdate", section = "Actions" },
    { name = "LSP manage", action = "Mason", section = "Actions" },
    { name = "Edit local config", action = "ConfigLocalEdit", section = "Actions" },
    { name = "Quit Neovim", action = "qall", section = "Actions" },
  },
  header = function()
    local hour = tonumber(fn.strftime "%H")
    -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
    local part_id = math.floor((hour + 4) / 8) + 1
    local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
    return ("Good %s, Kirill"):format(day_part)
  end,
  footer = function()
    local lazy_stats = require("lazy").stats()

    return (
      "Loaded "
      .. lazy_stats.loaded
      .. " from "
      .. lazy_stats.count
      .. " installed plugins. "
      .. "Load time: "
      .. fn.printf("%.3f", lazy_stats.times.LazyDone / 1000)
      .. " seconds.\n\n"
      .. default_footer
    )
  end,
}
