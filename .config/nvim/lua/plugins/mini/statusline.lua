require "tools/table"

vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { link = "SpellLocal" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { link = "SpellCap" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { link = "SpellBad" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { link = "SpellRare" })

return {
  "echasnovski/mini.statusline",
  opts = {
    content = {
      active = function()
        local groups = {}
        local trunc_width = 120
        local is_truncated = MiniStatusline.is_truncated(trunc_width)

        -- ModeInfo
        local spell = vim.wo.spell and (is_truncated and "S" or "SPELL") or ""
        local mode, mode_hl = MiniStatusline.section_mode { trunc_width = trunc_width }
        table.insert(groups, { hl = mode_hl, strings = { mode, spell } })

        -- Recording macro status
        local macro_recording = vim.fn.reg_recording()
        if macro_recording ~= "" then
          table.insert(groups, { strings = { "REC@" .. macro_recording } })
        end

        -- Git
        local git = MiniStatusline.section_git { trunc_width = trunc_width }
        table.insert(groups, { hl = "Statusline", strings = { git } })

        -- LSP
        -- if not is_truncated then
        --   -- table.insert(groups, {
        --   --   hl = "MiniStatuslineFilename",
        --   --   strings = {
        --   --     lsp_get_progress(),
        --   --     -- lsp_get_current_function(),
        --   --     -- get_current_scope(),
        --   --   },
        --   -- })
        --
        --   -- Diagnostic
        --   -- local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
        --   local diagnostic, diagnostic_hl = get_diagnostic()
        --   table.insert(groups, { hl = diagnostic_hl, strings = { diagnostic } })
        -- end

        -- Mark general truncate point
        table.insert(groups, "%<")

        local filename = MiniStatusline.section_filename { trunc_width = trunc_width }
        table.insert(groups, { hl = "MiniStatuslineFilename", strings = { filename } })

        -- Buffer number
        local bufnr = tostring(vim.api.nvim_get_current_buf())
        table.insert(groups, { hl = "MiniStatuslineFilename", strings = { "[b#" .. bufnr .. "]" } })

        -- End left alignment
        table.insert(groups, "%=")

        -- Fileinfo
        local fileinfo = MiniStatusline.section_fileinfo { trunc_width = trunc_width }
        table.insert(groups, { hl = "MiniStatuslineFilename", strings = { fileinfo } })

        -- Location
        table.insert(groups, { hl = mode_hl, strings = { "%2v:%l %p%%" } })

        -- Usage of `MiniStatusline.combine_groups()` ensures highlighting and
        -- correct padding with spaces between groups (accounts for 'missing'
        -- sections, etc.)
        return MiniStatusline.combine_groups(groups)
      end,
    },
  }
}
