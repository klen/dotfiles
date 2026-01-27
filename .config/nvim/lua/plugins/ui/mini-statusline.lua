return {
  "nvim-mini/mini.statusline",
  version = false,
  opts = function()
    local msl = require("mini.statusline")
    local trunc_width = 120

    return {
      use_icons = false,
      content = {
        active = function()
          local groups = {}
          local is_truncated = msl.is_truncated(trunc_width)

          -- ModeInfo
          local spell = vim.wo.spell and (is_truncated and "S" or "SPELL") or ""
          local mode, mode_hl = msl.section_mode({ trunc_width = trunc_width })
          table.insert(groups, { hl = mode_hl, strings = { mode, spell } })

          -- Recording macro status
          local macro_recording = vim.fn.reg_recording()
          if macro_recording ~= "" then
            table.insert(groups, { strings = { "REC@" .. macro_recording } })
          end

          -- Git
          local git = msl.section_git({ trunc_width = trunc_width })
          table.insert(groups, { hl = "Statusline", strings = { git } })

          -- Mark general truncate point
          table.insert(groups, "%<")

          -- Buffer number / Filename
          local bufnr = tostring(vim.api.nvim_get_current_buf())
          local filename = msl.section_filename({ trunc_width = trunc_width })
          table.insert(groups, { hl = "MiniStatuslineFilename", strings = { bufnr .. ":" .. filename } })

          -- End left alignment
          table.insert(groups, "%=")

          -- Fileinfo
          local fileinfo = msl.section_fileinfo({ trunc_width = trunc_width })
          table.insert(groups, { hl = "MiniStatuslineFilename", strings = { fileinfo } })

          -- Location
          table.insert(groups, { hl = mode_hl, strings = { "%2v:%l %p%%" } })

          -- Usage of `msl.combine_groups()` ensures highlighting and
          -- correct padding with spaces between groups (accounts for 'missing'
          -- sections, etc.)
          return msl.combine_groups(groups)
        end,
      },
    }
  end,
}
