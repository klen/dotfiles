require "configs/mini/starter"
require("mini.sessions").setup { directory = g.SESSION_DIR }

---@diagnostic disable: undefined-global
require("mini.statusline").setup {
  content = {
    active = function()
      -- stylua: ignore start
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local spell         = vim.wo.spell and (MiniStatusline.is_truncated(120) and 'S' or 'SPELL') or ''
      local wrap          = vim.wo.wrap  and (MiniStatusline.is_truncated(120) and 'W' or 'WRAP')  or ''
      local git           = MiniStatusline.section_git({ trunc_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local searchcount   = MiniStatusline.section_searchcount({ trunc_width = 75})
      local location      = MiniStatusline.section_location({ trunc_width = 75 })

      -- Usage of `MiniStatusline.combine_groups()` ensures highlighting and
      -- correct padding with spaces between groups (accounts for 'missing'
      -- sections, etc.)
      return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode, spell, wrap } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { searchcount, location } },
      })
      -- stylua: ignore end
    end,
  },
}

local themes = require "base16-themes"
local theme_names = vim.tbl_keys(themes)
local b16pos = 1

_G.cycle_base16 = function()
  b16pos = (b16pos % #theme_names) + 1
  require("mini.base16").setup {
    -- use_cterm = true,
    palette = themes[theme_names[b16pos]],
  }
end

-- require('mini.base16').setup()
-- require('mini.tabline').setup()

vim.defer_fn(function()
  -- require('mini.bufremove').setup()
  require("mini.comment").setup()
  -- require('mini.cursorword').setup()
  -- require("mini.jump").setup()
  -- require('mini.misc').setup()
  require("mini.pairs").setup { modes = { insert = true, command = false, terminal = false } }
  -- require("mini.surround").setup()
  require("mini.trailspace").setup()
end, 0)
