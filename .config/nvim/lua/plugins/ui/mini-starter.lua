local default_footer = [[
Type query to filter items
<BS> deletes latest character from query
<Down>/<Up> and <M-j>/<M-k> move current item
<CR> executes action of current item
<C-c> closes this buffer]]

return {
  "nvim-mini/mini.starter",
  opts = function()
    local starter = require("mini.starter")
    local lv = require("lazyvim.util")
    local new_section = function(name, action, section)
      return { name = name, action = action, section = section or "Actions" }
    end

    return {
      content_hooks = {
        starter.gen_hook.adding_bullet(), -- Adds a bullet point before each item
        starter.gen_hook.aligning("center", "center"), -- Centers content both horizontally and vertically
      },
      items = {
        -- Recent files
        starter.sections.recent_files(5, true),

        -- Actions
        new_section("Find file", lv.pick()),
        new_section("New file", "ene | startinsert"),
        new_section("Find text", lv.pick("live_grep")),
        new_section("Projects", [[lua require('snacks.picker').projects()]]),
        new_section("Restore session", [[lua require("persistence").load()]]),
        new_section("Config", lv.pick.config_files()),
        new_section("Lazy Extras", "LazyExtras"),
        new_section("Plugins", "Lazy"),
        new_section("Quit", "qa"),
      },
      header = function()
        local hour = tonumber(vim.fn.strftime("%H"))
        -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
        local part_id = math.floor((hour + 4) / 8) + 1
        local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
        local username = vim.loop.os_get_passwd()["username"] or "USERNAME"

        local fortune = vim.fn.system("fortune -s 2>/dev/null"):gsub("%s+$", "")
        return ("Good %s, %s!"):format(day_part, username) .. "\n\n" .. (fortune or "Welcome to Neovim!")
      end,
    }
  end,
  config = function(_, config)
    -- close Lazy and re-open when starter is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniStarterOpened",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    local starter = require("mini.starter")
    starter.setup(config)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function(ev)
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        starter.config.footer = (
          "Loaded "
          .. stats.loaded -- Number of loaded plugins
          .. " from "
          .. stats.count -- Total installed plugins
          .. " installed plugins. "
          .. "Load time: "
          .. vim.fn.printf("%.3f", stats.times.LazyDone / 1000) -- Load time in seconds
          .. " seconds.\n\n"
          .. default_footer -- Append the default navigation instructions
        )

        -- INFO: based on @nvim-mini's recommendation (thanks a lot!!!)
        if vim.bo[ev.buf].filetype == "ministarter" then
          pcall(starter.refresh)
        end
      end,
    })
  end,
}
