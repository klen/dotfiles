local statusline = require('mini.statusline')
local TRUNC_WIDTH = 120

statusline.setup {
  use_icons = false,
  content = {
    active = function ()
      local groups = {}
      local is_truncated = statusline.is_truncated(TRUNC_WIDTH)

      -- ModeInfo
      local spell = vim.wo.spell and (is_truncated and "S" or "SPELL") or ""
      local mode, mode_hl = statusline.section_mode({ trunc_width = TRUNC_WIDTH })
      table.insert(groups, { hl = mode_hl, strings = { mode, spell } })

      -- Recording macro status
      local macro_recording = vim.fn.reg_recording()
      if macro_recording ~= "" then
        table.insert(groups, { strings = { "REC@" .. macro_recording } })
      end

      -- Git
      local git = statusline.section_git({ trunc_width = TRUNC_WIDTH })
      table.insert(groups, { hl = "Statusline", strings = { git } })

      -- Mark general truncate point
      table.insert(groups, "%<")

      -- Buffer number / Filename
      local bufnr = tostring(vim.api.nvim_get_current_buf())
      local filename = statusline.section_filename({ trunc_width = TRUNC_WIDTH })
      table.insert(groups, { hl = "MiniStatuslineFilename", strings = { bufnr .. ":" .. filename } })

      -- End left alignment
      table.insert(groups, "%=")

      -- Fileinfo
      local fileinfo = statusline.section_fileinfo({ trunc_width = TRUNC_WIDTH })
      table.insert(groups, { hl = "MiniStatuslineFilename", strings = { fileinfo } })

      -- Location
      table.insert(groups, { hl = mode_hl, strings = { "%2v:%l %p%%" } })


      return statusline.combine_groups(groups)

    end
  }
}

