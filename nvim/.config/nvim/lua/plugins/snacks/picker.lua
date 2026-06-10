local map = vim.keymap.set
local picker = require("snacks.picker")

map("n", "<leader><space>", function()
  picker.files({
    layout = {
      preset = "vertical",
    }
  })
end, { desc = "Find files" })
map("n", "<leader>/", function() picker.grep() end, { desc = "Grep word" })

map('n', '<leader>f', '', { desc = "+find" }) -- Prefix for find commands
map("n", "<leader>fb", function() picker.buffers() end, { desc = "Find buffers" })
map("n", "<leader>fn", function() picker.notifications() end, { desc = "Find notifications" })
map("n", "<leader>fh", function() picker.help() end, { desc = "Find help tags" })
map('n', '<leader>fw', function() picker.grep_word() end, { desc = "Grep word under cursor" })
map('n', '<leader>fm', function() picker.keymaps() end, { desc = "Find keymaps" })
map('n', '<leader>fc', function() picker.highlights() end, { desc = "Find highlights" })
map("n", "<leader>fr", function() picker.recent() end, { desc = "Find recent files" })

map('n', '<leader>gl', function() picker.git_log_file() end, { desc = "Git commits (file)" })
map('n', '<leader>gL', function() picker.git_log() end, { desc = "Git commits (project)" })

map("n", "<leader>fs", function() picker.lsp_workspace_symbols() end, { desc = "Find LSP symbols" })

-- Workaround for snacks.nvim setqflist crash when item.buf references an invalid buffer.
-- Grep and some other pickers may leave item.buf as a stale or invalid bufnr,
-- which causes vim.fn.setqflist to throw a C-level error.
local function safe_setqflist(items, opts)
  local qf = {} ---@type vim.quickfix.entry[]
  for _, item in ipairs(items) do
    local bufnr = item.buf
    if bufnr and not vim.api.nvim_buf_is_valid(bufnr) then
      bufnr = nil
    end
    local filename = picker.util.path(item)
    if not filename and bufnr then
      filename = vim.api.nvim_buf_get_name(bufnr)
    end
    qf[#qf + 1] = {
      filename = filename,
      bufnr = bufnr,
      lnum = item.pos and item.pos[1] or 1,
      col = item.pos and item.pos[2] + 1 or 1,
      end_lnum = item.end_pos and item.end_pos[1] or nil,
      end_col = item.end_pos and item.end_pos[2] + 1 or nil,
      text = item.line or item.comment or item.label or item.name or item.detail or item.text,
      pattern = item.search,
      type = ({ 'E', 'W', 'I', 'N' })[item.severity],
      valid = true,
    }
  end
  if opts and opts.win then
    pcall(vim.fn.setloclist, opts.win, qf)
    vim.cmd('botright lopen')
  else
    pcall(vim.fn.setqflist, qf)
    vim.cmd('botright copen')
  end
end

return {
  sources = {
    files = {
      hidden = true,
    },
  },
  win = {
    input = {
      keys = {
        ["<C-j>"] = { "focus_list", mode = { "i", "n" } },
        ["<C-l>"] = { "focus_preview", mode = { "i", "n" } },
      },
    },
    list = {
      keys = {
        ["<C-c>"] = { "close", mode = { "i", "n" } },
        ["<C-k>"] = { "focus_input", mode = { "i", "n" } },
        ["<C-l>"] = { "focus_preview", mode = { "i", "n" } },
      },
    },
    preview = {
      keys = {
        ["<C-c>"] = { "close", mode = { "i", "n" } },
        ["<C-h>"] = { "focus_input", mode = { "i", "n" } },
      },
      wo = {
        wrap = true,
      },
    },
  },
  icons = {
    files = {
      enabled = false,
    },
    git = {
      enabled = false,
    },
  },
  actions = {
    qflist = function(p)
      p:close()
      local sel = p:selected()
      local items = #sel > 0 and sel or p:items()
      safe_setqflist(items)
    end,
    qflist_all = function(p)
      p:close()
      safe_setqflist(p:items())
    end,
    loclist = function(p)
      p:close()
      local sel = p:selected()
      local items = #sel > 0 and sel or p:items()
      safe_setqflist(items, { win = p.main })
    end,
  },
}
