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
  ignored = {}, -- dir -> set of ignored paths, one `git check-ignore` per dir
}

M.reset_cache = function()
  M.cache.ignored = {}
end

-- git answers for a whole directory at once; asking per entry spawned one
-- process per file and froze the browser on big directories.
local function ignored_paths(dir)
  local cached = M.cache.ignored[dir]
  if cached then
    return cached
  end

  local prefix = dir == '/' and '' or dir
  local paths = {}
  for _, name in ipairs(vim.fn.readdir(dir)) do
    paths[#paths + 1] = prefix .. '/' .. name
  end

  local ignored = {}
  if #paths > 0 then
    local cmd = 'git -C ' .. vim.fn.shellescape(prefix == '' and '/' or prefix) ..
        ' check-ignore --stdin 2>/dev/null'
    for _, path in ipairs(vim.fn.systemlist(cmd, table.concat(paths, '\n'))) do
      ignored[path] = true
    end
  end

  M.cache.ignored[dir] = ignored
  return ignored
end

M.filters = {
  hidden = {
    enabled = false,
    filter = function(entry)
      return not vim.startswith(entry.name, ".")
    end,
  },
  ignore = {
    enabled = true,
    filter = function(entry)
      local path = entry.path:gsub('/+$', '')
      local dir = path:match('^(.*)/[^/]*$')
      return not ignored_paths(dir == '' and '/' or dir)[path]
    end,
  },
}

return M
