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
vim.keymap.set('n', '<leader>pl', function() vim.cmd.PackGet() end, { desc = 'List plugins' })
vim.keymap.set('n', '<leader>pc', function() vim.cmd.PackCheck() end, { desc = 'Check plugins' })
