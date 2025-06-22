-- Alias for Neovim functions
local fn = vim.fn

-- Default footer text for the starter buffer, explaining navigation.
local default_footer = [[
Type query to filter items
<BS> deletes latest character from query
<Down>/<Up> and <M-j>/<M-k> move current item
<CR> executes action of current item
<C-c> closes this buffer]]

return {
  "echasnovski/mini.starter",
  config = function()
    -- Require the mini.starter plugin
    local starter = require("mini.starter")

    -- Setup `mini.starter` with custom content, header, and footer.
    starter.setup({
      -- Hooks to modify the displayed content (items, sections).
      content_hooks = {
        starter.gen_hook.adding_bullet(),          -- Adds a bullet point before each item
        starter.gen_hook.aligning("center", "center"), -- Centers content both horizontally and vertically
      },

      -- Define the items that will appear in the starter dashboard.
      items = {
        -- Section for recent files. Shows the last 10 files, and hides if empty.
        starter.sections.recent_files(10, true),
        -- starter.sections.sessions(5, true), -- Commented out: Section for recent sessions.

        -- Custom actions section. These are user-defined commands.
        { name = "New file",          action = "enew",            section = "Actions" },
        {
          name = "Find files",
          action = function()
            require("snacks").picker.smart() -- Opens a file picker using snacks.nvim
          end,
          section = "Actions"
        },

        -- Action to open the Lazy.nvim plugin management home page.
        {
          name = "Plugins manage",
          action = function()
            local lazy = require("lazy") -- Ensure lazy.nvim is loaded
            lazy.home()              -- Open Lazy.nvim dashboard
          end,
          section = "Actions",
        },
        { name = "Treesitter update", action = "TSUpdate",        section = "Actions" }, -- Assumes Treesitter command
        { name = "LSP manage",        action = "Mason",           section = "Actions" }, -- Assumes Mason command
        { name = "Edit local config", action = "ConfigLocalEdit", section = "Actions" }, -- Assumes custom command
        { name = "Quit Neovim",       action = "qall",            section = "Actions" }, -- Quits all buffers/windows
      },

      -- Custom header function. Displays a greeting based on the time of day.
      header = function()
        local hour = tonumber(fn.strftime("%H")) -- Get current hour (0-23)
        -- Determine part of the day:
        -- [04:00, 12:00) - morning
        -- [12:00, 20:00) - afternoon
        -- [20:00, 04:00) - evening (this range wraps around midnight)
        local part_id = math.floor((hour + 4) / 8) +
            1                                                                    -- Adjust hour and divide by 8-hour blocks
        local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id] -- Map ID to greeting
        return ("Good %s, Kirill"):format(day_part)                              -- Personalized greeting
      end,

      -- Custom footer function. Displays Lazy.nvim plugin statistics and default navigation help.
      footer = function()
        local lazy_stats = require("lazy").stats() -- Get plugin statistics from lazy.nvim

        return (
          "Loaded "
          .. lazy_stats.loaded -- Number of loaded plugins
          .. " from "
          .. lazy_stats.count -- Total installed plugins
          .. " installed plugins. "
          .. "Load time: "
          .. fn.printf("%.3f", lazy_stats.times.LazyDone / 1000) -- Load time in seconds
          .. " seconds.\n\n"
          .. default_footer                                  -- Append the default navigation instructions
        )
      end,
    })
  end,
}
