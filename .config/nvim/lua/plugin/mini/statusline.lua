local _, lsp_status = pcall(require, "lsp-status")

local _, gps = pcall(require, "nvim-gps")
if gps then
  gps.setup {
    icons = {
      ["class-name"] = " ", -- Classes and class-like objects
      ["function-name"] = " ", -- Functions
      ["method-name"] = " ", -- Methods (functions inside class-like objects)
      ["container-name"] = " ", -- Containers (example: lua tables)
      ["tag-name"] = "炙", -- Tags (example: html tags)  })
    },
  }
end

local get_current_scope = function()
  if gps then
    local info = gps.get_location()
    if info and #info > 0 then
      return string.format(": %s", info)
    end
  end
  return ""
end

local lsp_get_progress = function()
  if not lsp_status then
    return ""
  end
  local clients = lsp.buf_get_clients(0)
  local contents = ""
  if not vim.tbl_isempty(vim.tbl_keys(clients)) then
    local all_messages = lsp_status.messages()
    for _, msg in ipairs(all_messages) do
      if msg.progress then
        contents = msg.title
        if msg.message then
          contents = contents .. " " .. msg.message
        end
        if msg.percentage then
          contents = contents .. " (" .. msg.percentage .. "%%)"
        end
      elseif msg.status then
        contents = msg.content
      else
        contents = msg.content
      end
    end
  end
  return contents
end

local severity = vim.diagnostic.severity
local cfg = require "config"
local diagnostic_highlight_map = {
  [severity.ERROR] = "DiagnosticSignError",
  [severity.WARN] = "DiagnosticSignWarn",
  [severity.INFO] = "DiagnosticSignInfo",
  [severity.HINT] = "DiagnosticSignHint",
}
local get_diagnostic = function()
  local items = vim.diagnostic.get(0)
  local stats = {
    [severity.ERROR] = 0,
    [severity.WARN] = 0,
    [severity.INFO] = 0,
    [severity.HINT] = 0,
  }
  for _, item in ipairs(items) do
    stats[item.severity] = stats[item.severity] + 1
  end
  local contents_hl = "StatusLine"
  local contents = ""
  if stats[severity.ERROR] > 0 then
    contents_hl = "DiagnosticSignError"
  elseif stats[severity.WARN] > 0 then
    contents_hl = "DiagnosticSignWarn"
  elseif stats[severity.INFO] > 0 then
    contents_hl = "DiagnosticSignInfo"
  elseif stats[severity.HINT] > 0 then
    contents_hl = "DiagnosticSignHint"
  end
  for _, level in ipairs { 4, 3, 2, 1 } do
    if stats[level] > 0 then
      contents_hl = diagnostic_highlight_map[level]
      contents = " " .. string.sub(cfg.diagnostic.signs[level], 1, 1) .. stats[level] .. contents
    end
  end
  if #contents > 0 then
    contents = "" .. contents
  end
  return contents, contents_hl
end

vim.api.nvim_command "hi def link MiniStatuslineModeNormal SpellLocal"
vim.api.nvim_command "hi def link MiniStatuslineModeInsert SpellCap"
vim.api.nvim_command "hi def link MiniStatuslineModeCommand SpellBad"
vim.api.nvim_command "hi def link MiniStatuslineModeOther SpellRare"

require("mini.statusline").setup {
  content = {
    active = function()
      local groups = {}
      local trunc_width = 120
      local is_truncated = MiniStatusline.is_truncated(trunc_width)

      -- ModeInfo
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = trunc_width }
      local spell = vim.wo.spell and (is_truncated and "S" or "SPELL") or ""
      local wrap = vim.wo.wrap and (is_truncated and "W" or "WRAP") or ""
      table.insert(groups, { hl = mode_hl, strings = { mode, spell, wrap } })

      -- Fileinfo
      local fileinfo = MiniStatusline.section_fileinfo { trunc_width = trunc_width }
      table.insert(groups, { hl = mode_hl, strings = { fileinfo } })

      -- Git
      local git = MiniStatusline.section_git { trunc_width = trunc_width }
      table.insert(groups, { hl = "Statusline", strings = { git } })

      -- Mark general truncate point
      table.insert(groups, "%<")

      local filename = MiniStatusline.section_filename { trunc_width = trunc_width }
      table.insert(groups, { hl = "MiniStatuslineFilename", strings = { filename } })

      if not is_truncated then
        table.insert(groups, {
          hl = "MiniStatuslineFilename",
          strings = {
            get_current_scope(),
          },
        })
      end

      -- End left alignment
      table.insert(groups, "%=")

      -- LSP
      if not is_truncated then
        table.insert(groups, {
          hl = "MiniStatuslineFilename",
          strings = {
            lsp_get_progress(),
            -- lsp_get_current_function(),
            -- get_current_scope(),
          },
        })

        -- Diagnostic
        -- local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
        local diagnostic, diagnostic_hl = get_diagnostic()
        table.insert(groups, { hl = diagnostic_hl, strings = { diagnostic } })
      end

      -- Location
      table.insert(groups, { hl = mode_hl, strings = { "%2v:%l" } })

      -- Usage of `MiniStatusline.combine_groups()` ensures highlighting and
      -- correct padding with spaces between groups (accounts for 'missing'
      -- sections, etc.)
      return MiniStatusline.combine_groups(groups)
    end,
  },
}
