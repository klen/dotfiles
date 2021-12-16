return {
  "echasnovski/mini.nvim",
  config = function()
    local tools = require "tools"
    -- require('mini.bufremove').setup()
    -- require('mini.base16').setup()
    -- require("mini.comment").setup()
    -- require("mini.completion").setup()
    -- require("mini.cursorword").setup()
    -- require("mini.fuzzy").setup()
    require("mini.jump").setup()
    -- require("mini.misc").setup()
    require("mini.pairs").setup()
    require("mini.sessions").setup {
      autoread = false,
      autowrite = true,
    }
    tools.lua_command("-nargs=1 SessionRead", "MiniSessions.read(vim.fn.expand('<args>'))")
    tools.lua_command("-nargs=1 SessionWrite", "MiniSessions.write(vim.fn.expand('<args>'))")
    tools.lua_command("-nargs=0 SessionRestore", "MiniSessions.read(MiniSessions.get_latest())")

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
    require("mini.statusline").setup {
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
          local spell = vim.wo.spell and (MiniStatusline.is_truncated(120) and "S" or "SPELL") or ""
          local wrap = vim.wo.wrap and (MiniStatusline.is_truncated(120) and "W" or "WRAP") or ""
          local git = MiniStatusline.section_git { trunc_width = 75 }
          local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
          local filename = MiniStatusline.section_filename { trunc_width = 140 }
          local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
          local searchcount = MiniStatusline.section_searchcount { trunc_width = 75 }
          local location = MiniStatusline.section_location { trunc_width = 75 }

          -- Usage of `MiniStatusline.combine_groups()` ensures highlighting and
          -- correct padding with spaces between groups (accounts for 'missing'
          -- sections, etc.)
          return MiniStatusline.combine_groups {
            { hl = mode_hl, strings = { mode, spell, wrap } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { searchcount, location } },
          }
        end,
      },
    }
    -- require("mini.surround").setup()
    -- require("mini.tabline").setup()
    require("mini.trailspace").setup()
  end,
}
