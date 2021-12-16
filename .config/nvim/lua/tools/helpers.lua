local M = {}

M.vimgrep = function()
  vim.ui.input({
    prompt = "Search for pattern: ",
    default = fn.expand "<cword>",
  }, function(pattern)
    if not pattern then
      return vim.notify("Invalid pattern", "warning")
    end
    vim.ui.input({
      prompt = "Start searching from directory: ",
      default = fn.getcwd(),
      completion = "dir",
    }, function(startdir)
      if not pattern then
        return vim.notify("Invalid directory", "warning")
      end
      vim.ui.input({
        prompt = "Search in files matching pattern: ",
        default = "*.*",
      }, function(filepattern)
        local ok = pcall(
          cmd,
          "noautocmd lvimgrep /" .. pattern .. "/gj " .. startdir .. "/**/" .. filepattern
        )
        if ok then
          cmd "abo lope"
        else
          vim.notify("Not found: " .. pattern, "warn")
        end
      end)
    end)
  end)
end

M.toggle_number = function()
  if not vim.o.number then
    vim.o.number = true
  elseif not vim.o.relativenumber then
    vim.o.relativenumber = true
  else
    vim.o.number = false
    vim.o.relativenumber = false
  end
end

M.fast_save = function()
  if vim.o.modified then
    cmd "noautocmd write"
  end
  return fn.expand "%" ~= ""
end

return M
