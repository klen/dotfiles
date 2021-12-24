-- Helper for users configurations

local Config = {}
Config.__index = function(table, key)
  return table.opts[key]
end

function Config:init(initial)
  self.opts = initial
  setmetatable(self, Config)
  return self
end

function Config:setup(opts)
  self.opts = vim.tbl_deep_extend("force", self.opts, opts)
end

return Config
