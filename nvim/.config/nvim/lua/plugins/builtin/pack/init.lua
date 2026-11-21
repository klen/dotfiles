local cmd = vim.api.nvim_create_user_command

cmd('PackAdd', function(opts)
  vim.pack.add(opts.fargs)
end, { nargs = '+', desc = 'Add plugins (PackAdd user/repo)' })

cmd('PackUpdate', function(opts)
  if #opts.fargs == 0 then
    vim.pack.update()
    return
  end
  vim.pack.update(opts.fargs)
end, { desc = 'Update all plugins', nargs = "*" })

cmd('PackDel', function(opts) vim.pack.del(opts.fargs) end, { nargs = '+', desc = 'Delete plugins (space separated)' })

cmd('PackGet', function()
  local plugins = vim.pack.get()
  if #plugins == 0 then
    vim.notify('No plugins found', vim.log.levels.INFO)
    return
  end

  vim.print('Installed plugins:')
  print(" ")
  for _, plugin in ipairs(plugins) do
    vim.print(plugin.spec.name)
  end
  print(" ")
end, { desc = 'List all installed plugins' })

cmd('PackCheck', function()
  local plugins = vim.pack.get()
  local non_active = vim.iter(plugins)
      :filter(function(plugin) return not plugin.active end)
      :map(function(plugin) return plugin.spec.name end)
      :totable()

  if #non_active == 0 then
    vim.notify('All plugins are active', vim.log.levels.INFO)
    return
  end

  vim.print('Non active plugins:')
  print(" ")
  for _, name in ipairs(non_active) do
    vim.print(name)
  end
  print(" ")

  local choice = vim.fn.confirm('Do you want to delete these plugins?', '&Yes\n&No', 2)
  if choice == 1 then
    vim.pack.del(non_active)
    vim.notify('Deleted non active plugins', vim.log.levels.INFO)
    vim.api.nvim_exec_autocmds('User', { pattern = 'PackChanged' })
  else
    vim.notify('No plugins were deleted', vim.log.levels.INFO)
  end
end, { desc = 'Check for non active plugins' })

vim.keymap.set('n', '<leader>p', '', { desc = '+plugins' })
vim.keymap.set('n', '<leader>pu', function() vim.cmd.PackUpdate() end, { desc = 'Update plugins' })
vim.keymap.set('n', '<leader>pc', function() vim.cmd.PackCheck() end, { desc = 'Check plugins' })

-- Plain plugin list (no fuzzy search): 'u' update, 'd' delete, 'q' close.
local ns = vim.api.nvim_create_namespace('pack_list')

-- Mark a line with the number of new upstream commits (as of the last fetch).
local function mark(buf, row, text)
  if not vim.api.nvim_buf_is_valid(buf) then return end
  vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
    virt_text = { { text, 'DiagnosticInfo' } },
    virt_text_pos = 'eol',
  })
end

-- `HEAD` is detached here, so compare against the remote's default branch.
local function check_updates(buf, rows)
  for row, plugin in pairs(rows) do
    vim.system({ 'git', '-C', plugin.path, 'fetch', '--quiet' }, {}, function(fetch)
      if fetch.code ~= 0 then return end
      vim.system({ 'git', '-C', plugin.path, 'rev-list', '--count', 'HEAD..origin/HEAD' },
        { text = true },
        function(out)
          local count = out.code == 0 and tonumber(out.stdout) or nil
          if count and count > 0 then
            vim.schedule(function() mark(buf, row - 1, ' ↑' .. count) end)
          end
        end)
    end)
  end
end

local buf -- kept between openings, so `pl` reuses the existing split
local rows = {} -- 1-based line number -> plugin (nil for headers and blank lines)

local function render()
  local plugins = vim.pack.get()
  table.sort(plugins, function(a, b) return a.spec.name < b.spec.name end)

  local lines, headers = {}, {}
  rows = {}
  local function section(title, list)
    if #list == 0 then return end
    if #lines > 0 then lines[#lines + 1] = '' end
    lines[#lines + 1] = title
    headers[#lines] = true
    for _, plugin in ipairs(list) do
      lines[#lines + 1] = plugin.spec.name
      rows[#lines] = plugin
    end
  end

  section('Active plugins', vim.iter(plugins):filter(function(p) return p.active end):totable())
  section('Inactive plugins', vim.iter(plugins):filter(function(p) return not p.active end):totable())

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  for row in pairs(headers) do
    vim.api.nvim_buf_set_extmark(buf, ns, row - 1, 0, { end_col = #lines[row], hl_group = 'Title' })
  end
  check_updates(buf, rows)
end

local function current()
  return rows[vim.fn.line('.')]
end

local function jump_to_config(plugin)
  if not plugin then return end
  local name = plugin.spec.name

  -- Convention: plugins/<name without .nvim/.lua>.lua or .../init.lua, then any file with this `src`.
  local base = vim.fn.stdpath('config') .. '/lua/plugins/' .. name:gsub('%.nvim$', ''):gsub('%.lua$', '')
  local files = { base .. '.lua', base .. '/init.lua' }
  vim.list_extend(files, vim.fn.globpath(vim.fn.stdpath('config') .. '/lua', '**/*.lua', false, true))

  for _, file in ipairs(files) do
    if file and vim.fn.filereadable(file) == 1 then
      for lnum, line in ipairs(vim.fn.readfile(file)) do
        if line:find(plugin.spec.src, 1, true) then
          vim.cmd.edit(vim.fn.fnameescape(file))
          return vim.api.nvim_win_set_cursor(0, { lnum, 0 })
        end
      end
    end
  end
  vim.notify('No config found for ' .. name, vim.log.levels.WARN)
end

local function open_plugin_list()
  local win = buf and vim.fn.bufwinid(buf) or -1
  if win ~= -1 then return vim.api.nvim_set_current_win(win) end

  if not (buf and vim.api.nvim_buf_is_valid(buf)) then
    buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buflisted = false
    vim.keymap.set('n', 'u', function()
      local plugin = current()
      if plugin then vim.pack.update({ plugin.spec.name }) end
    end, { buffer = buf, desc = 'Update plugin' })
    vim.keymap.set('n', 'd', function()
      local plugin = current()
      if not plugin or vim.fn.confirm('Delete ' .. plugin.spec.name .. '?', '&Yes\n&No', 2) ~= 1 then return end
      -- vim.pack.add() in the config reinstalls it on next start unless its line is removed.
      vim.pack.del({ plugin.spec.name }, { force = true })
      vim.notify('Deleted ' .. plugin.spec.name .. ' from disk', vim.log.levels.INFO)
      render()
    end, { buffer = buf, desc = 'Delete plugin' })
    vim.keymap.set('n', '<CR>', function() jump_to_config(current()) end,
      { buffer = buf, desc = 'Open plugin config' })
    vim.keymap.set('n', 'r', render, { buffer = buf, desc = 'Reload list (re-check upstream)' })
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, desc = 'Close' })
  end

  render()
  vim.cmd.vsplit()
  vim.api.nvim_win_set_buf(0, buf)
  vim.wo.winbar = ' ⏎:config  u:update  d:delete  q:close '
end

vim.keymap.set('n', '<leader>pl', open_plugin_list, { desc = 'List plugins' })
