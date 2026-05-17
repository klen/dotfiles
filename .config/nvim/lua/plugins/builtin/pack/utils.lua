local M = {}

M.find_readme = function(path)
  for _, name in ipairs({
    'README.md',
    'README.markdown',
    'README.rst',
    'readme.md',
    'readme.markdown',
    'readme.rst',
  }) do
    local file = path .. '/' .. name

    if vim.fn.filereadable(file) == 1 then
      return file
    end
  end
end

M.list_plugins = function()
  local plugins = vim.pack.get()
  if #plugins == 0 then
    vim.notify('No plugins found', vim.log.levels.INFO)
    return
  end

  return vim.iter(plugins)
      :map(function(plugin)
        local name = plugin.spec.name or vim.fs.basename(plugin.path)
        local readme = M.find_readme(plugin.path)

        return {
          text = name,
          name = name,
          -- plugin_path = plugin.path,

          -- Snacks file previewer will preview this
          file = readme or plugin.path,

          -- optional: nicer preview title on newer snacks
          preview = {
            title = readme and (name .. ' README') or name,
          },

        }
      end)
      :totable()
end

return M
