-- Helper for users configurations

require "tools/table"

local Config = {}
Config.__index = function(table, key)
  return table.opts[key]
end

-- Initialize the configuration
function Config:init(initial)
  self.opts = initial
  self.callbacks = {}
  setmetatable(self, Config)
  vim.api.nvim_command 'command ConfigPrint lua require("config"):print()'
  return self
end

-- Update the configuration
function Config:update(opts)
  self.opts = vim.tbl_deep_extend("force", self.opts, opts)
end

-- Pring current configuration
function Config:print()
  vim.print(self.opts)
end

-- Get a value by the given path
function Config:get(path, default)
  local value = self.opts
  for part in string.gmatch(path, "[^%.]+") do
    if table.is_table(value) then
      value = value[part]
    else
      return default
    end
  end
  return value
end

-- Register a callback (TODO)
function Config:register(cb)
  if type(cb) == "function" then
    table.insert(self.callbacks, cb)
  end
end

return Config
