return {
  -- Only activate LSP for files inside a project (git repo or pyproject.toml).
  -- Files outside any project (temp dirs, netrw, etc.) are silently skipped.
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, { '.git', 'pyproject.toml', 'setup.py', 'setup.cfg', 'uv.lock', 'poetry.lock' })
    if root then
      on_dir(root)
    end
  end,
}
