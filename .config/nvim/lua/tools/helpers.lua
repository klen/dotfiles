local M = {}

-- Use vimgrep to search a word
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
          vim.cmd "abo lope"
        else
          vim.notify("Not found: " .. pattern, "warn")
        end
      end)
    end)
  end)
end

-- Toggle `number` option
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

-- Fast save file
M.fast_save = function()
  if vim.o.modified then
    vim.cmd "noautocmd write"
  end
  return vim.fn.expand "%" ~= ""
end

return M
