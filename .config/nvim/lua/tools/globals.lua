_G.api = vim.api
_G.cmd = vim.cmd
_G.fn = vim.fn
_G.g = vim.g
_G.lsp = vim.lsp

_G.printt = function(...)
  print(unpack(vim.tbl_map(vim.inspect, { ... })))
end

-- Table functions

function table.is_table(t)
  return type(t) == "table"
end

-- Pop a value from table
function table.pop(t, key)
  if not table.is_table(t) then
    return nil
  end
  local value = t[key]
  t[key] = nil
  return value
end

-- Check for table contains a value
function table.contains(t, value)
  if not table.is_table(t) then
    return nil
  end
  for _, v in ipairs(t) do
    if value == v then
      return true
    end
  end
  return false
end

-- Reverse the given table (inplace)
function table.reverse(t)
  if not table.is_table(t) then
    return nil
  end
  for idx = 1, math.floor(#t / 2) do
    t[idx], t[#t - idx + 1] = t[#t - idx + 1], t[idx]
  end
  return t
end

-- Get a value from the table by path
function table.get(value, path, default)
  for part in string.gmatch(path, "[^%.]+") do
    if table.is_table(value) then
      value = value[part]
    else
      return default
    end
  end
  return value
end
