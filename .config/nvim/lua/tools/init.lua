-- Vim Helper Utilities

local M = {}        -- Module table to export functions
local api = vim.api -- Alias for Neovim API
local fn = vim.fn   -- Alias for Neovim functions

--- Simulates key presses in Vim.
-- @param keys string: The keys to input.
-- @param mode string: (Optional) The mode in which to input keys (e.g., "i" for insert, "n" for normal). Defaults to "i".
function M.input(keys, mode)
  api.nvim_feedkeys(api.nvim_replace_termcodes(keys, true, true, true), mode or "i", true)
end

--- Reloads a specified Lua module.
-- Requires the 'plenary.reload' plugin.
-- @param module string: The name of the module to reload (e.g., "my_module").
-- @return boolean: True if reload was successful, false otherwise.
function M.reload(module)
  local ok, plenary_reload = pcall(require, "plenary.reload")
  if not ok then
    vim.notify("plenary.reload is not available. Cannot reload module: " .. module, vim.log.levels.ERROR)
    return false
  end
  return plenary_reload.reload_module(module)
end

--- Reloads a Lua module and then re-requires it, returning the fresh module table.
-- Useful for live-reloading configuration or plugin files without restarting Neovim.
-- @param module string: The name of the module to reload and require.
-- @return table: The re-required module table, or nil if reload/require fails.
function M.rrequire(module)
  if M.reload(module) then
    return require(module)
  end
  return nil
end

--- Conditionally configures a plugin to be loaded from a local path or a remote URL.
-- This is useful for developing plugins locally while maintaining the option to use
-- the remote version in other environments.
-- @param path string: The local path to the plugin directory (e.g., "~/dev/my-plugin").
-- @param source string: The remote URL for the plugin (e.g., "https://github.com/user/my-plugin").
-- @param opts table: (Optional) Additional options to merge with the plugin definition.
-- @return table: A plugin specification table suitable for `lazy.nvim` or similar.
function M.local_plugin(path, source, opts)
  -- If the local path exists and is a directory, use it; otherwise, use the remote source.
  return vim.tbl_extend(
    "force",    -- Forces overwrite for conflicting keys
    opts or {}, -- Start with provided options (or empty table)
    (fn.isdirectory(fn.expand(path)) == 1) and { dir = path } or { url = source }
  )
end

--- Prompts the user for a pattern, directory, and file pattern, then performs a `lvimgrep` search.
-- Results are shown in the location list (`:lopen`).
M.vimgrep = function()
  vim.ui.input({
    prompt = "Search for pattern: ",
    default = fn.expand "<cword>",                        -- Default to the word under the cursor
  }, function(pattern)
    if not pattern or pattern:gsub("^%s+", "") == "" then -- Check for empty or whitespace-only pattern
      return vim.notify("Search pattern cannot be empty.", vim.log.levels.WARN)
    end

    vim.ui.input({
      prompt = "Start searching from directory: ",
      default = fn.getcwd(), -- Default to current working directory
      completion = "dir",    -- Enable directory completion
    }, function(startdir)
      if not startdir or startdir:gsub("^%s+", "") == "" then
        return vim.notify("Search directory cannot be empty.", vim.log.levels.WARN)
      end

      vim.ui.input({
        prompt = "Search in files matching pattern: ",
        default = "*.*", -- Default to all files
      }, function(filepattern)
        local cmd_str = "noautocmd lvimgrep /" .. pattern .. "/gj " .. startdir .. "/**/" .. filepattern
        local ok, err = pcall(vim.cmd, cmd_str) -- Use pcall to catch errors from vim.cmd
        if ok then
          vim.cmd "abo lope"                    -- Open location list in a new window below
        else
          -- If pcall fails, it's likely a syntax error in the vimgrep command or invalid arguments
          vim.notify("Search failed. " .. (err or "No matches found or invalid command."), vim.log.levels.WARN)
        end
      end)
    end)
  end)
end

--- Toggles between no line numbers, absolute numbers, and relative numbers.
M.toggle_number = function()
  if not vim.o.number then             -- If 'number' is off, turn it on
    vim.o.number = true
    vim.o.relativenumber = false       -- Ensure relative numbers are off
    vim.notify("Line numbers: Absolute", vim.log.levels.INFO)
  elseif not vim.o.relativenumber then -- If 'number' is on but 'relativenumber' is off, turn relative on
    vim.o.relativenumber = true
    vim.o.number = true                -- Ensure absolute is also on for relative to show correctly
    vim.notify("Line numbers: Relative", vim.log.levels.INFO)
  else                                 -- Both are on, turn them both off
    vim.o.number = false
    vim.o.relativenumber = false
    vim.notify("Line numbers: Off", vim.log.levels.INFO)
  end
end

--- Saves the current file without triggering autocommands if modified.
-- @return boolean: True if the file was saved (and expanded path is not empty), false otherwise.
M.fast_save = function()
  if vim.o.modified then
    vim.cmd "noautocmd write" -- Write buffer without triggering BufWriteCmd/BufWritePre
    vim.notify("File saved!", vim.log.levels.INFO)
  else
    vim.notify("No changes to save.", vim.log.levels.INFO)
  end
  -- Return true if the buffer has a file name, indicating it's a "real" file
  return vim.fn.expand "%" ~= ""
end

--- Displays the syntax stack at the current cursor position.
-- Useful for debugging syntax highlighting issues.
M.synstack = function()
  local syn_ids = vim.fn.synstack(vim.fn.line("."), vim.fn.col("."))
  if #syn_ids == 0 then
    vim.notify("No syntax items at cursor.", vim.log.levels.INFO)
    return
  end
  vim.notify("Syntax stack at cursor:", vim.log.levels.INFO)
  for _, syn_id in ipairs(syn_ids) do
    vim.print(vim.fn.synIDattr(syn_id, "name"))
  end
end

return M
