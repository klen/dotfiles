-- Helper for user configurations

-- Ensure the 'tools/table' module is loaded for table utility functions.
-- This is assumed to provide `table.is_table`.
require("tools/table")

local Config = {}

-- Metatable __index to allow direct access to properties within `self.opts`.
-- If a key isn't found directly on the Config object, it will look in `self.opts`.
Config.__index = function(tbl, key)
  return tbl.opts[key]
end

--- Initializes the configuration object.
-- @param initial table: The initial configuration table.
-- @return table: The initialized Config instance.
function Config:init(initial)
  self.opts = initial or {}  -- Initialize with provided options or an empty table
  self.callbacks = {}        -- Store callbacks (for future use, as marked TODO)
  setmetatable(self, Config) -- Set the metatable to enable __index behavior

  -- Create a user command to print the current configuration.
  -- This makes debugging easier directly from Neovim.
  vim.api.nvim_create_user_command('ConfigPrint', 'lua require("config"):print()',
    { nargs = 0, desc = "Print current Neovim configuration" })

  return self
end

--- Updates the current configuration with new options.
-- Uses `vim.tbl_deep_extend("force", ...)` for a deep merge,
-- overwriting existing values with those from `opts`.
-- @param opts table: The table with new configuration options to merge.
function Config:update(opts)
  self.opts = vim.tbl_deep_extend("force", self.opts, opts or {})
end

--- Prints the current configuration to the Neovim messages area.
function Config:print()
  vim.print(self.opts)
end

--- Retrieves a value from the configuration using a dot-separated path.
-- @param path string: The dot-separated path to the desired value (e.g., "ui.colors.primary").
-- @param default any: (Optional) The default value to return if the path is not found.
-- @return any: The value found at the path, or the default value if not found.
function Config:get(path, default)
  local value = self.opts
  -- Iterate through parts of the path (e.g., "ui", "colors", "primary")
  for part in string.gmatch(path, "[^%.]+") do
    if type(value) == "table" and value[part] ~= nil then
      value = value[part]
    else
      -- If any part of the path is not a table or the key doesn't exist, return default.
      return default
    end
  end
  return value
end

--- Registers a callback function. (TODO: Implement callback execution logic)
-- This function is intended for future use, possibly to trigger actions
-- when the configuration changes.
-- @param cb function: The callback function to register.
function Config:register(cb)
  if type(cb) == "function" then
    table.insert(self.callbacks, cb)
  else
    vim.notify("Attempted to register a non-function callback in Config.", vim.log.levels.WARN)
  end
end

return Config
