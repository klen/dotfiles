return {
  preset = {
    keys = {
      { key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { key = "n", desc = "New File", action = ":ene | startinsert" },
      { key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
      { key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      {
        key = "p",
        desc = "Projects",
        action = ":lua Snacks.picker.projects()",
      },
      { key = "s", desc = "Restore Session", section = "session" },
      {
        key = "c",
        desc = "Config",
        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
      },
      { key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
      { key = "l", desc = "Lazy", action = ":Lazy" },
      { key = "q", desc = "Quit", action = ":qa" },
    },
  },
  formats = {
    -- disable icons
    icon = function()
      return ""
    end,
  },
  sections = {
    {
      hl = "header",
      indent = 4,
      cmd = "fortune -s",
      section = "terminal",
      padding = 1,
    },
    {
      padding = 1,
      title = "Recent Files",
      indent = 2,
      section = "recent_files",
    },
    {
      padding = 2,
      title = "Shortcuts",
      indent = 2,
      section = "keys",
    },
    {
      section = "startup",
      icon = "",
      padding = 2,
    },
  },
}
