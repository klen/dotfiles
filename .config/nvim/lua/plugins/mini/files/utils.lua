local miniFiles = require "mini.files"

local M = {}

M.map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local cur_target = miniFiles.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. " split")
      return vim.api.nvim_get_current_win()
    end)

    miniFiles.set_target_window(new_target)
    miniFiles.go_in()
    miniFiles.close()
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = "Split " .. direction
  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

local show_dotfiles = false

M.filter_dotfiles = function(entry)
  if show_dotfiles then
    return true
  end
  return not vim.startswith(entry.name, ".")
end

M.toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  miniFiles.refresh {
    content = { filter = M.filter_dotfiles },
  }
end

return M
