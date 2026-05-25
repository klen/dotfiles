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

M.filter = function(entry)
  for _, filter in pairs(M.filters) do
    if filter.enabled and not filter.filter(entry) then
      return false
    end
  end

  return true
end

M.toggle_filter = function(name)
  local filter = M.filters[name]
  if filter then
    filter.enabled = not filter.enabled
    vim.notify((filter.enabled and "Enabled" or "Disabled") .. " filter: " .. name, vim.log.levels.INFO,
      { title = "MiniFiles" })
  end

  miniFiles.refresh({
    content = {
      filter = M.filter,
    },
  })
end

M.cache = {
  gitignore = {},
}

M.reset_cache = function()
  M.cache.gitignore = {}
end

M.filters = {
  dotfiles = {
    enabled = true,
    filter = function(entry)
      return not vim.startswith(entry.name, ".")
    end,
  },
  gitignore = {
    enabled = true,
    filter = function(entry)
      -- vim.fn.system({ 'git', 'check-ignore', '--quiet', entry.path })
      -- return vim.v.shell_error ~= 0
      -- Cache results to avoid calling git for every file
      if M.cache.gitignore[entry.path] == nil then
        local result = vim.fn.system(
          { 'git', 'check-ignore', '--quiet', entry.path })
        M.cache.gitignore[entry.path] = vim.v.shell_error ~= 0
      end
      return M.cache.gitignore[entry.path]
    end,
  },
}

return M
